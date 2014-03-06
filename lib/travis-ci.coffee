https = require 'https'

module.exports =
# Internal: Interacts with the Travis-CI API.
class TravisCI
  # Internal: Make a request to the Travis-CI API, and return the response body
  # in the callback.
  #
  # method   - The string HTTP method.
  # path     - The string API path.
  # callback - The function callback that takes error and data arguments.
  #
  # Examples
  #
  #   travis.request 'GET', '/repos/tombell/travis-ci-status', (err, data) ->
  #     return console.error err if err?
  #     console.log data
  #
  # Returns nothing.
  request: (method, path, callback) ->
    options =
      'hostname': 'api.travis-ci.org'
      'port': 443
      'path': path
      'method': method.toUpperCase()
      'headers':
        'Content-Type': 'application/json'

    req = https.request options, (res) ->
      console.log "StatusCode:", res.statusCode
      console.log "Headers:", res.headers

      data = ''
      res.on 'data', (chunk) ->
        data += chunk

      res.on 'end', ->
        json = JSON.parse(data)
        console.log "Body:", json
        callback(null, json)

    req.on 'error', (err) ->
      console.log "Error:", err
      callback(err, null)

    req.end()
