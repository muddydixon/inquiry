"use strict"

React = require "react"
{EventEmitter} = require "events"
assign = require "object-assign"

Dispatcher = require "../dispatcher"
Constants = require "../constants"

CHANGE_EVENT = "change"

items = []

ItemStore = module.exports = assign {}, EventEmitter.prototype, {
  getAll: -> items
  create: (obj)->
    items.push obj

  emitChange: ->
    @emit CHANGE_EVENT
  addChangeListener: (callback)->
    @on CHANGE_EVENT, callback
  removeChangeListener: (callback)->
    @removeListener CHANGE_EVENT, callback
}

Dispatcher.register (payload)->
  action = payload.action

  switch action.actionType
    when Constants.ITEM_CREATE

      if action.item isnt ""
        ItemStore.create(action.item)
    else
      return true
  ItemStore.emitChange()
  true
