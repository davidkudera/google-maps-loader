if typeof window == 'undefined'
	throw new Error 'Google-maps package can be used only in browser.'

promiseError = ->
	throw new Error 'Using promises is not supported anymore. Please take a look in new documentation and use callback instead.'


class Google


	@URL: 'https://maps.googleapis.com/maps/api/js?sensor=false'

	@KEY: null

	@WINDOW_CALLBACK_NAME = '__google_maps_api_provider_initializator__'


	@script: null

	@google: null

	@loading: false

	@callbacks: []


	@load: (fn = null) ->
		if @google == null
			if @loading == true
				if fn != null
					@callbacks.push(fn)
			else
				@loading = true

				window[@WINDOW_CALLBACK_NAME] = =>
					@_ready(fn)

				url = @URL
				url += "&key=#{@KEY}" if @KEY != null
				url += "&callback=#{@WINDOW_CALLBACK_NAME}"

				@script = document.createElement('script')
				@script.type = 'text/javascript'
				@script.src = url

				document.body.appendChild(@script)
		else if fn != null
			fn(@google)

		return {
			then: -> promiseError()
			catch: -> promiseError()
			fail: -> promiseError()
		}


	@release: (fn) ->
		_release = =>
			@google = null
			@loading = false
			@callbacks = []

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


	@_ready: (fn = null) =>
		@loading = false

		if @google == null
			@google = window.google

		if fn != null
			fn(@google)

		for fn in @callbacks
			fn(@google)

		@callbacks = []


if typeof module == 'object'
	module.exports = Google
else
	window.GoogleMapsLoader = Google