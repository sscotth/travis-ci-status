TravisCiStatusView = require './travis-ci-status-view'
TravisCi = require './travis-ci'

module.exports =
  # Internal: The main Travis-CI status view.
  travisCiStatusView: null

  # Internal: Get whether the project repository exists and is hosted on GitHub.
  #
  # Returns true if the repository exists and is hosted on GitHub, else false.
  isGitHubRepo: ->
    repo = atom.project.getRepo()
    return false unless repo?
    /github\.com:/i.test(repo.getOriginUrl())

  # Internal: Active the package and initializes any views.
  #
  # Returns nothing.
  activate: (state) ->
    return unless @isGitHubRepo()
    atom.travis = new TravisCi
    @travisCiStatusView = new TravisCiStatusView(state.travisCiStatusViewState)

  # Internal: Deactive the package and destroys any views.
  #
  # Returns nothing.
  deactivate: ->
    atom.travis = null
    @travisCiStatusView?.destroy()

  # Internal: Serialize each view state so it can be restored when activated.
  #
  # Returns an object containing key/value pairs of view state data.
  serialize: ->
    travisCiStatusViewState: @travisCiStatusView.serialize()
