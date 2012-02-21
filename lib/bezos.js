(function() {
  var Bezos, crypto, qs;

  crypto = require('crypto');

  qs = require('querystring');

  Bezos = (function() {

    function Bezos(_secret) {
      this._secret = _secret;
    }

    Bezos.prototype.sign = function(verb, host, pathname, params) {
      var hmac, key, queryString, signature;
      params['Timestamp'] = new Date().toISOString();
      queryString = ((function() {
        var _i, _len, _ref, _results;
        _ref = Object.keys(params).sort();
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          key = _ref[_i];
          _results.push("" + key + "=" + (qs.escape(params[key])));
        }
        return _results;
      })()).join('&');
      hmac = crypto.createHmac('sha256', this._secret);
      hmac.update([verb, host, pathname, queryString].join("\n"));
      signature = hmac.digest('base64');
      return "" + pathname + "?" + queryString + "&Signature=" + (qs.escape(signature));
    };

    return Bezos;

  })();

  module.exports = Bezos;

}).call(this);
