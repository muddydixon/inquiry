"use strict"

React = require "react"

TextItem = require "./text-item"
TextareaItem = require "./textarea-item"
CheckItem = require "./check-item"
RadioItem = require "./radio-item"

defaultItem = ->
  name: "",
  description: ""
  type: "text",

ItemNew = module.exports = React.createClass
  getInitialState: ->
    item: @props.item or defaultItem()
  onTypeChange: (ev)->
    @state.item.type = @refs.type.getDOMNode().value or "text"
    @setState item: @state.item
  onSubmit: ->

  render: ->
    <div className="well">
      <form className="form-horizontal" role="form" method="POST" action="/api/inquiries/0" onSubmit={@onSubmit}>
        <div className="form-group">
          <label className="col-sm-2" htmlFor="name">タイトル</label>
          <div className="col-sm-10">
            <input type="text" className="form-control" id="name" name="name" />
          </div>
        </div>
        <div className="form-group">
          <label className="col-sm-2" htmlFor="desc">説明</label>
          <div className="col-sm-10">
            <input type="text" className="form-control" id="desc" name="desc" />
          </div>
        </div>
        <div className="form-group">
          <label className="col-sm-2" htmlFor="type">タイプ</label>
          <div className="col-sm-10">
            <select className="form-control" id="type" ref="type" onChange={@onTypeChange}>
              <option value="text">Text</option>
              <option value="textarea">Textarea</option>
              <option value="checkbox">Checkbox</option>
              <option value="radio">Radio</option>
            </select>
          </div>
        </div>
        <div className="form-group">
          <label className="col-sm-2">サンプル</label>
          {switch @state.item.type
            when "text"
              <TextItem />
            when "textarea"
              <TextareaItem />
            when "checkbox"
              <CheckItem />
            when "radio"
              <RadioItem />
          }
        </div>
        <div className="form-group">
          <label className="col-sm-2" htmlFor="type">必須項目</label>
          <div className="col-sm-10">
            <input type="checkbox" name="is_required" />
          </div>
        </div>
      </form>
    </div>
