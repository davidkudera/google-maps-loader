[![NPM version](https://badge.fury.io/js/google-maps.png)](http://badge.fury.io/js/google-maps)
[![Dependency Status](https://gemnasium.com/sakren/node-google-maps.png)](https://gemnasium.com/sakren/node-google-maps)
[![Build Status](https://travis-ci.org/sakren/node-google-maps.png?branch=master)](https://travis-ci.org/sakren/node-google-maps)

[![Donate](http://b.repl.ca/v1/donate-PayPal-brightgreen.png)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=ARUCDRF95XRBA)

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
* [Development version](https://raw.github.com/sakren/node-google-maps/master/lib/Google.js)
* [Production version](https://raw.github.com/sakren/node-google-maps/master/lib/Google.min.js)

## Usage

```
var GoogleMapsLoader = require('google-maps');		// only for common js environments

GoogleMapsLoader.load(function(google) {
	new google.maps.Map(el, options);
});
```

**If you are not using environment with common js support, you can use `GoogleMapsLoader` variable directly. It is
already in `window` object.**

## Options

### Own API key

```
GoogleMapsLoader.KEY = 'qwertyuiopasdfghjklzxcvbnm';
```

### Business API client

```
GoogleMapsLoader.CLIENT = 'yourclientkey';
GoogleMapsLoader.VERSION = '3.14';
```

### Sensor

```
GoogleMapsLoader.SENSOR = true
```

### Libraries

```
GoogleMapsLoader.LIBRARIES = ['geometry', 'places'];
```

## Unload google api

For testing purposes is good to remove all google objects and restore loader to its original state.
```
GoogleMapsLoader.release(function() {
	console.log('No google maps api around');
});
```

## Events

### onLoad

```
GoogleMapsLoader.onLoad(function(google) {
	console.log('I just loaded google maps api');
});
```

## Tests

```
$ npm test
```

## Changelog list

* 2.1.1
	+ Sh**.... Forgot to increase version at package.json

* 2.1.0
	+ Added support for libraries [#3](https://github.com/sakren/node-google-maps/pull/3) (thanks [popara](https://github.com/popara))
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