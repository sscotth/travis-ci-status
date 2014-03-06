{View} = require 'atom'

module.exports =
# Internal: The main view for displaying the status from Travis-CI.
class TravisCiStatusView extends View
  # Internal: Build up the HTML contents for the fragment.
  @content: ->
    @div class: 'travis-ci-status overlay from-top', =>
      @div "The TravisCiStatus package is Alive! It's ALIVE!", class: "message"

  # Internal: Initialize the view using serialized state if it exists.
  #
  # serializedState - The object containing key/value pairs of state data.
  initialize: (serializeState) ->
    atom.workspaceView.command "travis-ci-status:toggle", => @toggle()

  # Internal: Serialize the state of this view.
  #
  # Returns an object containing key/value pairs of state data.
  serialize: ->

  # Internal: Destroy the view and tear down any state.
  #
  # Returns nothing.
  destroy: ->
    @detach()

  # Internal: Toggle the visibility of the view.
  #
  # Returns nothing.
  toggle: ->
    console.log "TravisCiStatusView was toggled!"
    if @hasParent()
      @detach()
    else
      atom.workspaceView.append(this)
