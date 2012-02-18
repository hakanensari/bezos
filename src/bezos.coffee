crypto      = require 'crypto'
querystring = require 'querystring'

# Bezos timestamps and signs requests to various Amazon APIs.
class Bezos
  constructor: (@_secret) ->

  # Returns a signed path for given request.
  sign: (host, pathname, params, method = 'GET') ->
    params['Timestamp'] = new Date().toISOString()

    query = (
      for key in Object.keys(params).sort()
        "#{key}=#{querystring.escape params[key]}"
    ).join('&')

    hmac = crypto.createHmac 'sha256', @_secret
    hmac.update [
      method,
      host,
      pathname,
      query
    ].join("\n")
    signature = hmac.digest 'base64'

    "#{pathname}?#{query}&Signature=#{querystring.escape signature}"

module.exports = Bezos
