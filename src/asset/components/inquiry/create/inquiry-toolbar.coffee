"use strict"

React = require "react"
ItemActions = require "../../../actions/item-actions"

ItemNew = require "./item-new"

defaultItem = ->
  type:  "text"
  value: ""
  desc:  ""

InquiryToolbar = module.exports = React.createClass
  onAddItem: (ev)->
    ev.preventDefault()
    ItemActions.create defaultItem()
  render: ->
    <div className="inquiry-toolbar btn-group">
      <button className="btn btn-sm btn-primary" onClick={@onAddItem}>アイテムを追加</button>
      <button className="btn btn-sm btn-primary" onClick={@props.onSubmit}>保存</button>
    </div>
