Q = require 'q'

class Google


	@URL: 'https://maps.googleapis.com/maps/api/js'

	@KEY: null

	@CLIENT: null

	@SENSOR: false

	@VERSION: "3.14"

	@WINDOW_CALLBACK_NAME = '__google_maps_api_provider_initializator__'


	@google: null

	@loading: false

	@promises: []


	@load: ->
		deferred = Q.defer()

		if @google == null
			if @loading == true
				@promises.push(deferred)
			else
				@loading = true

				window[@WINDOW_CALLBACK_NAME] = =>
					@_ready(deferred)

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

				# Add the business API client parameter if provided
				#
				url += "&client=#{@CLIENT}&v=#{@VERSION}" if @CLIENT?

				url += "&callback=#{@WINDOW_CALLBACK_NAME}"

				script = document.createElement('script')
				script.type = 'text/javascript'
				script.src = url

				document.body.appendChild(script)
		else
			deferred.resolve(@google)

		return deferred.promise


	@_ready: (deferred) =>
		@loading = false
		if @google == null then @google = window.google
		deferred.resolve(@google)
		for def in @promises
			def.resolve(@google)
		@promises = []


module.exports = Google