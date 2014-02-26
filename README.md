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

## Own API key

```
Loader.KEY = 'qwertyuiopasdfghjklzxcvbnm';
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

## Business API client

```
Loader.CLIENT = 'yourclientkey';
Loader.VERSION = '3.14';
```

## Changelog list

* 1.0.1
    + Added Maps API for Business support

* 1.0.0
	+ Initial version