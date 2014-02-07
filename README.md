# Google Maps

Wrapper for asynchronously used Google Maps API in browser.
Returns promise.

## Changelog

Changelog is in the bottom of this readme.

## Usage

```
var Loader = require('google-maps');
Loader.load().then(function(google) {
	// new google.maps.Map(el, options);
});
```

This module does not change original google maps api in any way. It just provide easy way to load and use this API asynchronously.

## Own API key

```
Loader.KEY = 'qwertyuiopasdfghjklzxcvbnm';
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