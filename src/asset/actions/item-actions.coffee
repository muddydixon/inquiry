"use strict"

Dispatcher = require "../dispatcher"
Constants = require "../constants"

ItemActions = module.exports = {
  create: (item)->
    Dispatcher.handleViewAction
      actionType: Constants.ITEM_CREATE
      item: item
}