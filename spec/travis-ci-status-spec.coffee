TravisCiStatus = require '../lib/travis-ci-status'
{WorkspaceView} = require 'atom'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "TravisCiStatus", ->
  activationPromise = null

  beforeEach ->
    spyOn(atom.project, 'getRepo').andReturn({
      getOriginUrl: ->
        'git@github.com:test/test.git'
    })

    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('travis-ci-status')

  describe "when the travis-ci-status:toggle event is triggered", ->
    it "attaches and then detaches the view", ->
      expect(atom.workspaceView.find('.travis-ci-status')).not.toExist()

      # This is an activation event, triggering it will cause the package to be
      # activated.
      atom.workspaceView.trigger 'travis-ci-status:toggle'

      waitsForPromise ->
        activationPromise

      runs ->
        expect(atom.workspaceView.find('.travis-ci-status')).toExist()
        atom.workspaceView.trigger 'travis-ci-status:toggle'
        expect(atom.workspaceView.find('.travis-ci-status')).not.toExist()
