# @cjsx React.DOM

Array::diff = (a) ->
  @filter (i) ->
    a.indexOf(i) < 0


urlParams = ->
  search = location.search.substring(1)
  (if search then JSON.parse("{\"" + search.replace(/&/g, "\",\"").replace(RegExp("=", "g"), "\":\"") + "\"}", (key, value) ->
    (if key is "" then value else decodeURIComponent(value))
  ) else {})

React       = require("react")
ReactAsync  = require("react-async")
ReactRouter = require("react-router-component")
superagent  = require("superagent")
NotFoundHandler = require("./components/notfound.coffee")

Pages       = ReactRouter.Pages
Page        = ReactRouter.Page
NotFound    = ReactRouter.NotFound
Link        = ReactRouter.Link



# MENU ======================================================================
Menu = React.createClass
  onSubmit: (e) ->
    e.preventDefault()
    @props.parseSoundcloud(@refs.urlVal.getDOMNode().value)

  render: ->
    <div className="menu #{if @props.menuOpen then 'visible' else ''}">
      <h3>Hello World</h3>
    </div>



# HEADER ======================================================================
Header = React.createClass
  render: ->
    nowPlaying = if @props.nowPlaying then "play" else "pause"
    <header>
      <h1>Pause Stats</h1>
      <a href="#" id="menu-toggle" onClick={@props.toggleMenu} className="menu_toggle"></a>
      <a href="#" id="play-toggle" onClick={@props.togglePlay} className="play_toggle #{nowPlaying}"></a>
    </header>



# MAIN ======================================================================
MainPage = React.createClass


  getInitialState: ->
    menu: true

  componentDidMount: ->
    console.log "computer sez: componentDidMount"

  render: ->
    <div id="main" className="">
      <Menu />
    </div>



# APP ======================================================================
App = React.createClass
  render: ->
    <Pages className="App" path={@props.path} ref="router" >
      <Page path="/*" handler={MainPage} app={@} />
    </Pages>




module.exports = App
if typeof window isnt "undefined"
  window.onload = ->
    React.renderComponent App(), document.getElementById('app')
