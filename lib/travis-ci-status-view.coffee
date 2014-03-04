{View} = require 'atom'

module.exports =
class TravisCiStatusView extends View
  @content: ->
    @div class: 'travis-ci-status overlay from-top', =>
      @div "The TravisCiStatus package is Alive! It's ALIVE!", class: "message"

  initialize: (serializeState) ->
    atom.workspaceView.command "travis-ci-status:toggle", => @toggle()

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    console.log "TravisCiStatusView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
