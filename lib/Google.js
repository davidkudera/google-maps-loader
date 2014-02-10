(function() {
  var Google, Q;

  Q = require('q');

  Google = (function() {
    function Google() {}

    Google.URL = 'https://maps.googleapis.com/maps/api/js';

    Google.KEY = null;

    Google.CLIENT = null;

    Google.SENSOR = false;

    Google.VERSION = "3.14";

    Google.WINDOW_CALLBACK_NAME = '__google_maps_api_provider_initializator__';

    Google.google = null;

    Google.loading = false;

    Google.promises = [];

    Google.load = function() {
      var deferred, script, url;
      deferred = Q.defer();
      if (this.google === null) {
        if (this.loading === true) {
          this.promises.push(deferred);
        } else {
          this.loading = true;
          window[this.WINDOW_CALLBACK_NAME] = (function(_this) {
            return function() {
              return _this._ready(deferred);
            };
          })(this);
          url = this.URL;
          if (this.SENSOR === true || this.SENSOR === "true") {
            url += "?sensor=true";
          } else {
            url += "?sensor=false";
          }
          if (this.KEY != null) {
            url += "&key=" + this.KEY;
          }
          if (this.CLIENT != null) {
            url += "&client=" + this.CLIENT + "&v=" + this.VERSION;
          }
          url += "&callback=" + this.WINDOW_CALLBACK_NAME;
          script = document.createElement('script');
          script.type = 'text/javascript';
          script.src = url;
          document.body.appendChild(script);
        }
      } else {
        deferred.resolve(this.google);
      }
      return deferred.promise;
    };

    Google._ready = function(deferred) {
      var def, _i, _len, _ref;
      Google.loading = false;
      if (Google.google === null) {
        Google.google = window.google;
      }
      deferred.resolve(Google.google);
      _ref = Google.promises;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        def = _ref[_i];
        def.resolve(Google.google);
      }
      return Google.promises = [];
    };

    return Google;

  })();

  module.exports = Google;

}).call(this);
