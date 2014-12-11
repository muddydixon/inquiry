"use strict"

React = require "react"
$ = require "jquery"

Item = module.exports = React.createClass
  getInitialState: ->
    item: @props.item

  renderItem: (item)->
    if item.type is "text"
      @renderText(item)
    else if item.type is "textarea"
      @renderTextarea(item)
    else if item.type is "check"
      @renderCheck(item)
    else if item.type is "select"
      @renderSelect(item)

  renderText: (item)->
    <div>
      <input type="text" name="text" />
    </div>
  renderTextarea: (item)->
    <div>
      <textarea name="textarea" />
    </div>
  renderCheck: (item)->
    <div>
      <input type="checkbox" name="check" />
    </div>
  renderSelect: (item)->
    <div>
      <select name="select">
      </select>
    </div>

  render: ->
    <div className="item">
      <p>{@state.item.name}</p>
      {@renderItem(@state.item)}
    </div>