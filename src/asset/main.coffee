"use strict"

React = require "react"
Router = require "react-router"
Routes = Router.Routes
Route  = Router.Route
DefaultRoute = Router.DefaultRoute
RouteHandler = Router.RouteHandler

Header      = require "./components/header"
Inquiries   = require "./components/inquiries"
Inquiry     = require "./components/inquiry"
InquiryNew  = require "./components/inquiry/create/inquiry-new"
ThankYou    = require "./components/thankyou"

App = module.exports = React.createClass
  render: ->
    <div className="container">
      <Header />
      <RouteHandler/>
    </div>

routes =
  <Route path="" handler={App}>
    <DefaultRoute handler={Inquiries} />
    <Route name="inquiries" handler={Inquiries} />
    <Route name="inquiry" handler={Inquiry} />
    <Route name="inquiry/new" path="/inquiry/new" handler={InquiryNew} />
    <Route name="thankyou" path="/thankyou" handler={ThankYou} />
  </Route>

Router.run routes, (Handler, status)->
  React.render <Handler />, document.body
