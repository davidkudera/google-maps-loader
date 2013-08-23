Q = require 'q'

class Google


	@URL: 'https://maps.googleapis.com/maps/api/js?sensor=false'

	@KEY: null

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
				url += "&key=#{@KEY}" if @KEY != null
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