(function() {
  var Bezos, crypto, querystring;

  crypto = require('crypto');

  querystring = require('querystring');

  Bezos = (function() {

    function Bezos(_secret) {
      this._secret = _secret;
    }

    Bezos.prototype.sign = function(host, pathname, params, method) {
      var hmac, key, query, signature;
      if (method == null) method = 'GET';
      params['Timestamp'] = new Date().toISOString();
      query = ((function() {
        var _i, _len, _ref, _results;
        _ref = Object.keys(params).sort();
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          key = _ref[_i];
          _results.push("" + key + "=" + (querystring.escape(params[key])));
        }
        return _results;
      })()).join('&');
      hmac = crypto.createHmac('sha256', this._secret);
      hmac.update([method, host, pathname, query].join("\n"));
      signature = hmac.digest('base64');
      return "" + pathname + "?" + query + "&Signature=" + (querystring.escape(signature));
    };

    return Bezos;

  })();

  module.exports = Bezos;

}).call(this);
