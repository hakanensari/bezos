crypto = require 'crypto'
qs     = require 'querystring'

# Bezos timestamps and signs requests to various Amazon APIs.
class Bezos
  constructor: (@_secret) ->

  # Returns a signed path for given request.
  sign: (verb, host, pathname, params) ->
    params['Timestamp'] = new Date().toISOString()

    queryString = (
      for key in Object.keys(params).sort()
        "#{key}=#{qs.escape params[key]}"
    ).join('&')

    hmac = crypto.createHmac 'sha256', @_secret
    hmac.update [
      verb,
      host,
      pathname,
      queryString
    ].join("\n")
    signature = hmac.digest 'base64'

    "#{pathname}?#{queryString}&Signature=#{qs.escape signature}"

module.exports = Bezos
