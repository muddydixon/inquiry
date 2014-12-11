"use strict"

React = require "react"

TextItem = module.exports = React.createClass
  render: ->
    <div className="col-sm-10">
      <input className="form-control" disabled=true type="text" value="テキスト"/>
    </div>
