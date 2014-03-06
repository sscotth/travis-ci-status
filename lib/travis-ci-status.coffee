TravisCiStatusView = require './travis-ci-status-view'

module.exports =
  # Internal: The main Travis-CI status view.
  travisCiStatusView: null

  # Internal: Active the package and initializes any views.
  #
  # Returns nothing.
  activate: (state) ->
    @travisCiStatusView = new TravisCiStatusView(state.travisCiStatusViewState)

  # Internal: Deactive the package and destroys any views.
  #
  # Returns nothing.
  deactivate: ->
    @travisCiStatusView.destroy()

  # Internal: Serialize each view state so it can be restored when activated.
  #
  # Returns an object containing key/value pairs of view state data.
  serialize: ->
    travisCiStatusViewState: @travisCiStatusView.serialize()
