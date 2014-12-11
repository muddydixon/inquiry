"use strict"

React = require "react"
$ = require "jquery"

Home = module.exports = React.createClass
  getInitialState: ->
    inquiries: []
  componentWillMount: ->
    $.get("/api/inquiries")
    .done((inquiries)=>
      console.log inquiries
      @setState
        inquiries: inquiries
    )
  render: ->
    console.log @state
    <div>
      <h2>アンケート一覧</h2>
      {@state.inquiries.map (inquiry)->
        <li><a href="/inquiries/#{inquiry.id}">{inquiry.name}</a></li>
      }
    </div>