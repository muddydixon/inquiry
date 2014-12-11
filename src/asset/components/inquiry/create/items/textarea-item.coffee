"use strict"

React = require "react"

TextareaItem = module.exports = React.createClass
  render: ->
    <div className="col-sm-10">
      <textarea className="form-control" disabled=true rows="3">テキストエリア</textarea>
    </div>
