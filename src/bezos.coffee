crypto      = require 'crypto'
querystring = require 'querystring'

# Bezos timestamps and signs requests to various Amazon APIs.
class Bezos
  constructor: (@_secret) ->

  # Signs a given URL.
  sign: (url, method = 'GET') ->
    params = if url.query.constructor == Object
               url.query
             else
               querystring.parse url.query

    params['Timestamp'] = new Date().toISOString()

    query = (
      for key in Object.keys(params).sort()
        "#{key}=#{querystring.escape params[key]}"
    ).join('&')

    hmac = crypto.createHmac 'sha256', @_secret
    hmac.update [
      method,
      url.hostname,
      url.pathname,
      query
    ].join("\n")
    signature = hmac.digest 'base64'
    url.query = "#{query}&Signature=#{querystring.escape signature}"

    url

module.exports = Bezos
