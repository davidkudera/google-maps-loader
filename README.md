[![NPM version](https://img.shields.io/npm/v/google-maps.svg?style=flat-square)](https://www.npmjs.com/package/google-maps)
[![Dependency Status](https://img.shields.io/gemnasium/Carrooi/Node-GoogleMaps.svg?style=flat-square)](https://gemnasium.com/Carrooi/Node-GoogleMaps)
[![Build Status](https://img.shields.io/travis/Carrooi/Node-GoogleMaps.svg?style=flat-square)](https://travis-ci.org/Carrooi/Node-GoogleMaps)

[![Donate](https://img.shields.io/badge/donate-PayPal-brightgreen.svg?style=flat-square)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=ARUCDRF95XRBA)

# Google Maps

Wrapper for asynchronously used Google Maps API in browser.

This module does not change original google maps api in any way. It just provide easy way to load and use this API
asynchronously.

## Installation

Environment with common js:
```
$ npm install google-maps
```

Download and import one of these files into your .html file:
* [Development version](https://raw.github.com/Carrooi/Js-GoogleMapsLoader/master/lib/Google.js)
* [Production version](https://raw.github.com/Carrooi/Js-GoogleMapsLoader/master/lib/Google.min.js)

## Usage

```javascript
var GoogleMapsLoader = require('google-maps'); // only for common js environments

GoogleMapsLoader.load(function(google) {
	new google.maps.Map(el, options);
});
```

**If you are not using environment with common js support, you can use `GoogleMapsLoader` variable directly. It is
already in `window` object.**

## Options

### Own API key

```javascript
GoogleMapsLoader.KEY = 'qwertyuiopasdfghjklzxcvbnm';
```

### Business API client

```javascript
GoogleMapsLoader.CLIENT = 'yourclientkey';
GoogleMapsLoader.VERSION = '3.14';
```

### Libraries

```javascript
GoogleMapsLoader.LIBRARIES = ['geometry', 'places'];
```

### Localization

```javascript
GoogleMapsLoader.LANGUAGE = 'fr';
```

### Region

```javascript
GoogleMapsLoader.REGION = 'GB';
```

## Unload google api

For testing purposes is good to remove all google objects and restore loader to its original state.

```javascript
GoogleMapsLoader.release(function() {
	console.log('No google maps api around');
});
```

## Events

### onLoad

```javascript
GoogleMapsLoader.onLoad(function(google) {
	console.log('I just loaded google maps api');
});
```

## Tests

```
$ npm test
```

## Changelog list

* 3.2.1
	+ Typo in readme

* 3.2.0
	+ Removed support for SENSOR parameter [#34](https://github.com/Carrooi/Js-GoogleMapsLoader/pull/34)
	+ Add support for REGION parameter [#36](https://github.com/Carrooi/Js-GoogleMapsLoader/pull/36)
	+ Removed deprecated promises API [#24](https://github.com/Carrooi/Js-GoogleMapsLoader/issues/24)
	+ Fix some testing cases [#23](https://github.com/Carrooi/Js-GoogleMapsLoader/pull/23)
	+ Typo in readme [#22](https://github.com/Carrooi/Js-GoogleMapsLoader/pull/22)

* 3.1.0
	+ Fix mock google maps loader 
	+ Add language parameter [#17](https://github.com/Carrooi/Js-GoogleMapsLoader/pull/17)
	+ Fix typos at readme [#19](https://github.com/Carrooi/Js-GoogleMapsLoader/pull/19)
	+ Fix for IE 8 [#21](https://github.com/Carrooi/Js-GoogleMapsLoader/pull/21)
	+ Rename repository to Js-GoogleMapsLoader [#15](https://github.com/Carrooi/Js-GoogleMapsLoader/issues/15)

* 3.0.0
	+ Register to bower registry
	+ Moved to Carrooi organization
	+ Using mocked loader, so tests are much faster
	+ Optimized building request url
	+ Some variables and methods are now private and not accessible from outside
	+ Updated dependencies
	+ Whole package is written in javascript, not coffeescript

* 2.1.1
	+ Sh**.... Forgot to increase version at package.json

* 2.1.0
	+ Added support for libraries [#3](https://github.com/Carrooi/Js-GoogleMapsLoader/pull/3) (thanks [popara](https://github.com/popara))
	+ Added tests
	+ Small optimization

* 2.0.0
	+ Added Maps API for Business support
	+ Added standalone version for non common js environments
	+ Removed dependency on [q](https://github.com/kriskowal/q) package
	+ Using callback instead of promise
	+ Added tests + travis
	+ Added status badges

* 1.0.0
	+ Initial version
