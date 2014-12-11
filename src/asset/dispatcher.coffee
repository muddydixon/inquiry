"use strict"

{Dispatcher} = require "flux"
assign = require "object-assign"

AppDispatcher = module.exports = assign new Dispatcher(), {
  handleViewAction: (action)->
    @dispatch
      source: "VIEW_ACTION"
      action: action
}
