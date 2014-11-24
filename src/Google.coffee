if typeof window == 'undefined'
	throw new Error 'Google-maps package can be used only in browser.'

promiseError = ->
	throw new Error 'Using promises is not supported anymore. Please take a look in new documentation and use callback instead.'


class Google


	@URL: 'https://maps.googleapis.com/maps/api/js'

	@KEY: null

	@LIBRARIES: []
	
	@CLIENT: null

	@SENSOR: false

	@_VERSION = "3.14"

	@VERSION: @_VERSION

	@WINDOW_CALLBACK_NAME = '__google_maps_api_provider_initializator__'


	@script: null

	@google: null

	@loading: false

	@callbacks: []

	@onLoadEvents: []


	@load: (fn = null) ->
		if @google == null
			if @loading == true
				if fn != null
					@callbacks.push(fn)
			else
				@loading = true

				window[@WINDOW_CALLBACK_NAME] = =>
					@_ready(fn)

				@script = document.createElement('script')
				@script.type = 'text/javascript'
				@script.src = @createUrl()

				document.body.appendChild(@script)
		else if fn != null
			fn(@google)

		return {
			then: -> promiseError()
			catch: -> promiseError()
			fail: -> promiseError()
		}


	@createUrl: ->
		url = @URL

		# Add the sensor check variable
		# We're being flexible with boolean or string input here
		#
		if @SENSOR is true or @SENSOR is "true"
			url += "?sensor=true"
		else
			url += "?sensor=false"

		# Add the client key if provided
		#
		url += "&key=#{@KEY}" if @KEY?

		# Add Libraries keyword if provided
		#
		url += "&libraries=#{@LIBRARIES.join ','}" if @LIBRARIES.length > 0

		# Add the business API client parameter if provided
		#
		url += "&client=#{@CLIENT}&v=#{@VERSION}" if @CLIENT?

		# Load data to temporary global callback (jsonp)
		url += "&callback=#{@WINDOW_CALLBACK_NAME}"

		return url


	@release: (fn) ->
		_release = =>
			@KEY = null
			@LIBRARIES = []
			@CLIENT = null
			@SENSOR = false
			@VERSION = @_VERSION

			@google = null
			@loading = false
			@callbacks = []
			@onLoadEvents = []

			if typeof window.google != 'undefined'
				delete window.google

			if typeof window[@WINDOW_CALLBACK_NAME] != 'undefined'
				delete window[@WINDOW_CALLBACK_NAME]

			if @script != null
				@script.parentElement.removeChild(@script)
				@script = null

			fn()

		if @loading
			@load( -> _release() )
		else
			_release()


	@onLoad: (fn) ->
		@onLoadEvents.push(fn)


	@_ready: (fn = null) =>
		@loading = false

		if @google == null
			@google = window.google

		for event in @onLoadEvents
			event(@google)

		if fn != null
			fn(@google)

		for fn in @callbacks
			fn(@google)

		@callbacks = []


if typeof module == 'object'
	module.exports = Google
else
	window.GoogleMapsLoader = Google
