{View} = require 'atom'

module.exports =
# Internal: The main view for displaying the status from Travis-CI.
class TravisCiStatusView extends View
  # Internal: Build up the HTML contents for the fragment.
  @content: ->
    @div class: 'travis-ci-status inline-block', =>
      @span class: 'build-status icon icon-history', outlet: 'status', tabindex: -1, ''

  # Internal: Initialize the view using serialized state if it exists.
  #
  # serializedState - The object containing key/value pairs of state data.
  initialize: (serializeState) ->
    atom.workspaceView.command 'travis-ci-status:toggle', => @toggle()
    @attach()

  # Internal: Serialize the state of this view.
  #
  # Returns an object containing key/value pairs of state data.
  serialize: ->

  # Internal: Attach the status bar segment to the status bar.
  #
  # Returns nothing.
  attach: ->
    atom.workspaceView.statusBar.appendLeft(this)

  # Internal: Destroy the view and tear down any state.
  #
  # Returns nothing.
  destroy: ->
    @detach()

  # Internal: Toggle the visibility of the view.
  #
  # Returns nothing.
  toggle: ->
    if @hasParent()
      @detach()
    else
      @attach()
