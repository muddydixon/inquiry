"use strict"

React = require "react"
$ = require "jquery"
qs = require "querystring"

TextItem = require "./items/text-item"
TextareaItem = require "./items/textarea-item"
CheckItem = require "./items/check-item"
RadioItem = require "./items/radio-item"

defaultItem = ->
  name: "",
  description: ""
  type: "text"
  onEditing: true

ItemNew = module.exports = React.createClass
  getInitialState: ->
    item: @props.item or defaultItem()

  onTypeChange: (ev)->
    @state.item.type = @refs.type.getDOMNode().value or "text"
    console.log @state.item
    @setState item: @state.item
  onNameChange: (ev)->
    @state.item.name = @refs.name.getDOMNode().value
    @setState item: @state.item
  onDescChange: (ev)->
    @state.item.description = @refs.desc.getDOMNode().value
    @setState item: @state.item
  onOptionsChange: (options)->
    @state.item.options = options
    @setState item: @state.item
  onRequiredChange: (ev)->
    @state.item.is_required = @refs.is_required.getDOMNode().value or false
    @setState item: @state.item

  onClickToToggleStatus: (ev)->
    @state.item.onEditing = !@state.item.onEditing
    @setState item: @state.item
  onClickToDuplicate: (ev)->
  onClickToDelete: (ev)->

  render: ->
    <div className="well">
      {if @state.item.onEditing
        <div>
          <div className="form-group">
            <label>{@state.item.name}</label>
            {if @state.item.description
              <p>{@state.item.description}</p>
            }
            {switch @state.item.type
              when "text"
                <input className="form-control" type="text" value="" />
              when "textarea"
                <textarea className="form-control" />
              when "checkbox"
                <div>
                  {@state.item.options.map (option)->
                    <div className="checkbox">
                      <label>
                        <input className="form-control" type="checkbox" value={option} />
                        {option}
                      </label>
                    </div>
                  }
                </div>
              when "radio"
                <div>
                  {@state.item.options.map (option)->
                    <div className="radio">
                      <label>
                        <input className="form-control" type="radio" value={option} />
                        {option}
                      </label>
                    </div>
                  }
                </div>
            }
          </div>
        </div>
      else
        <div>
          <div className="form-group">
            <label className="col-sm-2" htmlFor="name">タイトル</label>
            <div className="col-sm-10">
              <input type="text" className="form-control" ref="name" id="name" name="name" onChange={@onNameChange} value={@state.item.name} />
            </div>
          </div>
          <div className="form-group">
            <label className="col-sm-2" htmlFor="desc">説明</label>
            <div className="col-sm-10">
              <input type="text" className="form-control" ref="desc" id="desc" name="desc" onChange={@onDescChange} value={@state.item.description} />
            </div>
          </div>
          <div className="form-group">
            <label className="col-sm-2" htmlFor="type">タイプ</label>
            <div className="col-sm-10">
              <select className="form-control" id="type" ref="type" onChange={@onTypeChange} value={@state.item.type}>
                {["text", "textarea", "checkbox", "radio"].map (type)=>
                  <option value={type}>{type}</option>
                }
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
                <CheckItem options={@state.item.options or [null]} onChange={@onOptionsChange} />
              when "radio"
                <RadioItem options={@state.item.options or [null]} onChange={@onOptionsChange} />
            }
          </div>
          <div className="form-group">
            <label className="col-sm-2" htmlFor="type">必須項目</label>
            <div className="col-sm-10">
              <input type="checkbox" ref="is_required" onChange={@onRequiredChange}/>
            </div>
          </div>
        </div>
      }
      <div className="btn-group" role="group">
        <button type="button" className="btn btn-default" onClick={@onClickToToggleStatus}>
          <i className="fa fa-edit" />
        </button>
        <button type="button" className="btn btn-default" onClick={@onClickToDuplicate}>
          <i className="fa fa-copy" />
        </button>
        <button type="button" className="btn btn-default" onClick={@onClickToDelete}>
          <i className="fa fa-trash" />
        </button>
      </div>
    </div>
