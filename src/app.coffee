"use strict"

Path         = require "path"
Fs           = require "fs"
MySQL        = require "mysql"
deferred     = require "deferred"
moment       = require "moment"
http         = require "http"
uuid         = require "uuid"

express      = require "express"
serveStatic  = require "serve-static"
bodyParser   = require "body-parser"
cookieParser = require "cookie-parser"
session      = require "express-session"

port = process.env.PORT or 5000
app = express()
app.use serveStatic "public", {index: ["index.html"]}
app.use bodyParser()
app.use cookieParser()
app.use session {secret: "hoge"}

con = MySQL.createConnection(user: "inquiry", password: "inquiry", database: "inquiry")
con.dQuery = ->
  d = deferred()
  args = [].slice.apply arguments
  args.push ()->
    arg = [].slice.apply arguments
    err = arg.shift()
    if err then d.reject(err) else d.resolve.apply d, arg
  con.query.apply con, args
  d.promise

con.dQuery("SELECT COUNT(*) AS cnt FROM inquiries")
.then(([{cnt}])->
  console.log "current inquiries", cnt
)
.catch((err)->
  console.log err
  process.exit -1
)

# index
app.get "/api/inquiries", (req, res, next)->
  con.dQuery("SELECT * FROM inquiries")
  .then((inquiries)->
    res.json inquiries or []
  )
  # .catch(next)
  .catch(next)

# create
app.post "/api/inquiries", (req, res, next)->
  console.log req.body
  con.dQuery("""
    INSERT INTO inquiries (name, created_at, updated_at) VALUE (?, ?, ?)
    """,
    [req.body.name, new Date(), new Date()]
  )
  .catch((err)->
    console.log err
    throw err
  )
  .then((result)->
    req.body.id = result.insertId
    console.log result, req.body
    return [] if req.body.items?.length is 0
    con.dQuery("""
      INSERT INTO items (
        inquiry_id, order_id, name, description,
        type, options, is_required,
        created_at, updated_at) VALUES ?
    """, [
      req.body.items.map (item, idx)->
        [
          req.body.id, idx, item.name, item.desc,
          item.type, JSON.stringify(item.options), item.is_required and true or false,
          new Date(), new Date()
        ]
    ])
    .then((result)->
      req.body.items.forEach (item, idx)-> item.id = result.insertId + idx
      res.set "Location", "/inquiry/#{req.body.id}"
      res.json 201, req.body
    )
  )
  .catch(next)

# get inquiry
app.get "/api/inquiries/:id", (req, res, next)->
  deferred(
    con.dQuery("SELECT * FROM inquiries WHERE id = ?", req.params.id)
    con.dQuery("SELECT * FROM items WHERE inquiry_id = ?", req.params.id)
    con.dQuery("SELECT * FROM answers WHERE inquiry_id = ? AND session = ?", [req.params.id, req.session.user?.uuid])
  )
  .then(([inquiry, items, answer])->
    inquiry = inquiry[0]
    answer = answer?[0] or null
    inquiry.items = items
    res.json {inquiry, answer}
  )
  .catch(next)

# answer inquiry
app.post "/api/inquiries/:id", (req, res, next)->
  req.session.user = {uuid: uuid()} unless req.session.user
  con.dQuery("INSERT INTO answers (inquiry_id, item_id, session, json) VALUES (?, ?, ?, ?)",
    [req.params.id, 0, req.session.user.uuid, JSON.stringify(req.body)]
  )
  .then((answer)->
    res.json answer
  )
  .catch((err)->
    if err.code is "ER_DUP_ENTRY"
      err = new Error("回答は一度だけでお願い致します")
    next(err)
  )

app.use (err, req, res, next)->
  console.log err
  res.json err.status or 500, {error: err.message}

index = Fs.readFileSync "public/index.html"
# app.get "/*", (req, res)->
#   res.set "Content-Type", "text/html"
#   res.send index

server = http.createServer(app)
server.listen(port)
server.on "listening", ->
  console.log "start server on #{port}"
