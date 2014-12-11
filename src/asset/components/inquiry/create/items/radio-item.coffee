"use strict"

React = require "react"
$ = require "jquery"

TextareaItem = module.exports = React.createClass
  getInitialState: ->
    options: @props.options
  getOptionIndex: (ev)->
    option = $(ev.target).parents(".option")
    option.prevAll().length
  onChange: (ev)->
    ev.preventDefault()
    @state.options[@getOptionIndex(ev)] = $(ev.target).val().trim()
    @setState options: @state.options
    @props.onChange(@state.options)
  onClick: (ev)->
    ev.preventDefault()
    @state.options.push null
    @setState options: @state.options
    @props.onChange(@state.options)
  onRemove: (ev)->
    ev.preventDefault()
    @state.options.splice(@getOptionIndex(ev), 1)
    @setState options: @state.options
    @props.onChange(@state.options)
  render: ->
    <div className="col-sm-10">
      {@state.options.map (option, idx)=>
        <div className="option">
          <input type="radio" disabled=true name="" />
          &nbsp; <input type="text" placeholder={"項目#{idx + 1}"} value={option} onChange={@onChange}/>
          &nbsp; <i className="fa fa-times-circle" onClick={@onRemove}/>
        </div>
      }
      <div>
        <input type="radio" disabled=true />
        &nbsp; <input type="text" placeholder="項目を追加" readOnly=true onClick={@onClick}/>
      </div>
    </div>
