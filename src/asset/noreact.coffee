"use strict"

$ = require "jquery"
qs = require "querystring"

checkRequired = ($items, data)->
  data = qs.parse data
  errors = new Error("入力が必須な項目があります")
  errors.errors = {}
  $items.each (id, item)->
    $group = $(item).parents(".form-group")
    tagName = item.tagName
    name = item.getAttribute("name")
    val = $(item).val()
    label = $group.find("[for=#{name}]")?.text() or ""

    isRequired = $group.find(".required").length > 0
    if isRequired and (not data[name]? or val.match(/^\s*$/))
      errors.errors[name] = new Error("入力が必須です (#{label}: #{name})")

  if Object.keys(errors.errors).length > 0
    throw errors

notifyError = (errors)->
  $notifications = $(".notifications").eq(0)
  appendNotification = (err)->
    $notifications.append(
      $("<div>", class: "alert alert-danger", role: "alert").text(err.message).append(
        $("<a>", class: "close").on("click", -> $(@).parents(".alert").remove()).append(
          $("<span>", class: "glyphicon glyphicon-remove-sign")
        )
      )
    )
  unless errors.errors
    appendNotification errors
  else
    for name, err of errors.errors
      appendNotification err
  $notifications.toggleClass "hide"

$ ->
  $("form").on "submit", (ev)->
    data = $(@).serialize()
    try
      checkRequired $(@).find("input,select,textarea"), data
    catch err
      notifyError err
      return false

    target = $(@).attr("action")
    $.post(target, data)
    .done((res)->
      location.href = "/#/thankyou"
    )
    .fail((xhr)->
      try
        error = JSON.parse(xhr.responseText)
      catch err
        notifyError err
        return false

      error = new Error(error.error)
      notifyError error

      return false
    )
    return false
