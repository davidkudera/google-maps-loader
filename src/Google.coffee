if typeof window == 'undefined'
	throw new Error 'Google-maps package can be used only in browser.'


class Google


	@URL: 'https://maps.googleapis.com/maps/api/js?sensor=false'

	@KEY: null

	@WINDOW_CALLBACK_NAME = '__google_maps_api_provider_initializator__'


	@google: null

	@loading: false

	@callbacks: []


	@load: (fn) ->
		if @google == null
			if @loading == true
				@callbacks.push(fn)
			else
				@loading = true

				window[@WINDOW_CALLBACK_NAME] = =>
					@_ready(fn)

				url = @URL
				url += "&key=#{@KEY}" if @KEY != null
				url += "&callback=#{@WINDOW_CALLBACK_NAME}"

				script = document.createElement('script')
				script.type = 'text/javascript'
				script.src = url

				document.body.appendChild(script)
		else
			fn(@google)

		return {
			then: ->
				throw new Error 'Using promises is not supported anymore. Please take a look in new documentation and use callback instead.'
		}


	@_ready: (fn = null) =>
		@loading = false

		if @google == null
			@google = window.google

		fn(@google)

		for fn in @callbacks
			fn(@google)

		@callbacks = []


if typeof module == 'object'
	module.exports = Google
else
	window.GoogleMapsLoader = Google