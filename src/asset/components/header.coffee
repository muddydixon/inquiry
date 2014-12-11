"use strict"

React = require "react"
{Link} = require "react-router"


Header = module.exports = React.createClass
  render: ->
     <div className="navbar navbar-default">
       <div className="navbar-header">
         <Link className="navbar-brand withripple" to="inquiries">アンケートシステム<div className="ripple-wrapper"></div></Link>
       </div>
       <div className="navbar-collapse collapse navbar-responsive-collapse">
         <ul className="nav navbar-nav">
           <li><Link to="inquiry/new">作成</Link></li>
         </ul>
       </div>
     </div>
