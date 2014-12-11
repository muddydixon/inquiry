"use strict"

React = require "react"
$ = require "jquery"

Inquiry = require "./inquiry"

Inquiries = module.exports = React.createClass
  getInitialState: ->
    inquiries: []
  componentWillMount: ->
    $.get("/api/inquiries")
    .done((inquiries)=>
      @setState inquiries: inquiries
    )
    .fail((err)->
      console.log err
    )

  createInquiry: ->

  render: ->
    <div>
      {@state.inquiries.map (inquiry)->
        <Inquiry inquiry={inquiry} />
      }
    </div>
