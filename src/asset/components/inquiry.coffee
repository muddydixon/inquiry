"use strict"

React = require "react"
$ = require "jquery"

Inquiry = module.exports = React.createClass
  getInitialState: ->
    inquiry: @props.inquiry
  componentWillMount: ->
    $.get("/api/inquiry/#{@props.inquiry.id}")
    .done((inquiries)=>
      @setState inquiries: inquiries
    )
    .fail((err)->
      console.log err
    )
  render: ->
    <div>
      <h2>{@state.inquiry.name}</h2>
    </div>
