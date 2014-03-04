TravisCiStatus = require '../lib/travis-ci-status'

# Use the command `window:run-package-specs` (cmd-alt-ctrl-p) to run specs.
#
# To run a specific `it` or `describe` block add an `f` to the front (e.g. `fit`
# or `fdescribe`). Remove the `f` to unfocus the block.

describe "TravisCiStatus", ->
  activationPromise = null

  beforeEach ->
    atom.workspaceView = new WorkspaceView
    activationPromise = atom.packages.activatePackage('travisCiStatus')

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
