TravisCiStatusView = require './travis-ci-status-view'

module.exports =
  travisCiStatusView: null

  activate: (state) ->
    @travisCiStatusView = new TravisCiStatusView(state.travisCiStatusViewState)

  deactivate: ->
    @travisCiStatusView.destroy()

  serialize: ->
    travisCiStatusViewState: @travisCiStatusView.serialize()
