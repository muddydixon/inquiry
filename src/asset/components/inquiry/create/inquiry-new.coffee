"use strict"

React = require "react"
{Link} = require "react-router"
$ = require "jquery"

InquiryToolbar = require "./inquiry-toolbar"
ItemStore = require "../../../stores/item-store"
ItemNew           = require "./item-new"

InquiryForm = module.exports = React.createClass
  defaultItem: ->
    name: "",
    description: ""
    type: "text"
    onEditing: true
  getInitialState: ->
    ItemStore.create @defaultItem()

    name: ""
    items: ItemStore.getAll()
  onNameChange: ->
    @setState
      name: @refs.name.getDOMNode().value
      items: @state.items
  onChange: ->
    @setState items: ItemStore.getAll()
  componentWillMount: ->
    ItemStore.addChangeListener @onChange
  componentWillUnmount: ->
    ItemStore.removeChangeListener @onChange
  onSubmit: (ev)->
    ev.preventDefault()
    $.post("/api/inquiries", {name: @state.name, items: @state.items})
    .done((result)->
      console.log result
    )
    .fail((err)->
      console.log err
    )

  render: ->
    <div>
      <form className="form-horizontal" role="form" method="POST" action="/api/inquiries" onSubmit={@onSubmit}>
        <div className="form-group">
          <label htmlFor="name">アンケートタイトル</label>
          <input type="text" className="form-control" ref="name" id="name" placeholder="タイトル" onChange={@onNameChange}/>
        </div>
        <div className="items">
          {@state.items.map (item)->
            <ItemNew item={item}/>
          }
        </div>
        <InquiryToolbar onSubmit={@onSubmit}/>
      </form>
    </div>
