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

  # Internal: Get the repoistory's name with owner.
  #
  # Returns a string of the name with owner, or null if the origin URL doesn't
  # exist.
  getRepoNwo: ->
    repo = atom.project.getRepo()
    url  = repo.getOriginUrl()
    return null unless url?
    url.replace(/git@github\.com:/i, '')
      .replace(/https:\/\/github\.com\//i, '')
      .replace(/\.git/i, '')

  # Internal: Active the package and initializes any views.
  #
  # Returns nothing.
  activate: (state) ->
    return unless @isGitHubRepo()
    atom.travis = new TravisCi

    createStatusEntry = =>
      @travisCiStatusView = new TravisCiStatusView(state.travisCiStatusViewState)

    if atom.workspaceView.statusBar
      createStatusEntry()
    else
      atom.packages.once 'activated', ->
        createStatusEntry()

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
