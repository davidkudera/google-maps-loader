# Google Maps

Wrapper for asynchronously used Google Maps API in browser.

## Usage

```
var Loader = require('google-maps');
Loader.load(function(google) {
	new google.maps.Map(el, options);
});
```

This module does not change original google maps api in any way. It just provide easy way to load and use this API
asynchronously.

## Own API key

```
Loader.KEY = 'qwertyuiopasdfghjklzxcvbnm';
```

## Changelog list

* 1.0.0
	+ Initial version