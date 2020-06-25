# google-maps-loader

Async loader for google maps api.

**Version >= 4.0.0:** Typescript definitions are published with this package. Install `@types/google-maps` for previous 
versions.

This module does not change original google maps api in any way. It just provide easy way to load and use this API
asynchronously.

**Browser only!**

## Installation

```
$ npm install --save google-maps
```

or with [Pika](https://www.pika.dev/npm/google-maps):

```html
<script type="module">
    import { Loader } from 'https://cdn.pika.dev/google-maps';
    // todo: see docs bellow
</script>
```

## Usage

```typescript
import {Loader, LoaderOptions} from 'google-maps';
// or const {Loader} = require('google-maps'); without typescript

const options: LoaderOptions = {/* todo */};
const loader = new Loader('my-api-key', options);

const google = await loader.load();
const map = new google.maps.Map(document.getElementById('map'), {
    center: {lat: -34.397, lng: 150.644},
    zoom: 8,
});
```

**Without await/async:**

```typescript
loader.load().then(function (google) {
    const map = new google.maps.Map(document.getElementById('map'), {
        center: {lat: -34.397, lng: 150.644},
        zoom: 8,
    });
});
```

## Options

* `version`: [https://developers.google.com/maps/documentation/javascript/versions](https://developers.google.com/maps/documentation/javascript/versions)
* `client`: [https://developers.google.com/maps/documentation/javascript/get-api-key#client-id](https://developers.google.com/maps/documentation/javascript/get-api-key#client-id)
* `channel`: [https://developers.google.com/maps/premium/reports/usage-reports#channels](https://developers.google.com/maps/premium/reports/usage-reports#channels)
* `language`: [https://developers.google.com/maps/documentation/javascript/localization](https://developers.google.com/maps/documentation/javascript/localization)
* `region`: [https://developers.google.com/maps/documentation/javascript/localization#Region](https://developers.google.com/maps/documentation/javascript/localization#Region)
* `libraries`: [https://developers.google.com/maps/documentation/javascript/libraries](https://developers.google.com/maps/documentation/javascript/libraries)

## Changelog list

* 4.2.3
    + Add support for IE11 [#78](https://github.com/davidkudera/google-maps-loader/pull/78)

* 4.2.2
    + Allow authorization using `clientID` [#77](https://github.com/davidkudera/google-maps-loader/pull/77) 

* 4.2.0
    + Add official types from @types/googlemaps

* 4.1.1
    + Rebuild package

* 4.1.0
    + Reject on load error
    + Reject on authentication error

* 4.0.0
    + Rewrite in typescript with await/async support

* 3.2.1
    + Typo in readme

* 3.2.0
    + Removed support for SENSOR parameter [#34](https://github.com/davidkudera/google-maps-loader/pull/34)
    + Add support for REGION parameter [#36](https://github.com/davidkudera/google-maps-loader/pull/36)
    + Removed deprecated promises API [#24](https://github.com/davidkudera/google-maps-loader/issues/24)
    + Fix some testing cases [#23](https://github.com/davidkudera/google-maps-loader/pull/23)
    + Typo in readme [#22](https://github.com/davidkudera/google-maps-loader/pull/22)

* 3.1.0
    + Fix mock google maps loader 
    + Add language parameter [#17](https://github.com/davidkudera/google-maps-loader/pull/17)
    + Fix typos at readme [#19](https://github.com/davidkudera/google-maps-loader/pull/19)
    + Fix for IE 8 [#21](https://github.com/davidkudera/google-maps-loader/pull/21)
    + Rename repository to Js-GoogleMapsLoader [#15](https://github.com/davidkudera/google-maps-loader/issues/15)

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
    + Added support for libraries [#3](https://github.com/davidkudera/google-maps-loader/pull/3) (thanks [popara](https://github.com/popara))
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
