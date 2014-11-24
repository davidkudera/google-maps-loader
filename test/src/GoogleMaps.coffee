baseUrl = GoogleMapsLoader.URL
cb = GoogleMapsLoader.WINDOW_CALLBACK_NAME

describe 'GoogleMaps', ->

	afterEach( (done) ->
		GoogleMapsLoader.release( ->
			done()
		)
	)

	describe '#load()', ->

		it 'should throw an error if promise style is used', ->
			expect( -> GoogleMapsLoader.load().then()).to.throw(Error, 'Using promises is not supported anymore. Please take a look in new documentation and use callback instead.')

		it 'should load google api object', (done) ->
			GoogleMapsLoader.load( (google) ->
				expect(google).to.be.a('object')
				expect(google).to.have.keys(['maps'])
				done()
			)

		it 'should load google api only for first time and then use stored object', (done) ->
			count = 0
			GoogleMapsLoader.onLoad( -> count++ )
			GoogleMapsLoader.load()
			GoogleMapsLoader.load()
			GoogleMapsLoader.load()
			GoogleMapsLoader.load( ->
				expect(count).to.be.equal(1)
				done()
			)

	describe '#release()', ->

		it 'should restore google maps package to original state and remove google api object completely and load it again', (done) ->
			GoogleMapsLoader.load( ->
				GoogleMapsLoader.release( ->
					expect(GoogleMapsLoader.google).to.be.null
					expect(window.google).to.be.undefined

					GoogleMapsLoader.load( (google) ->
						expect(google).to.be.a('object')
						expect(google).to.have.keys(['maps'])
						done()
					)
				)
			)

	describe '#createUrl()', ->

		it 'should create url with sensor support', ->
			GoogleMapsLoader.SENSOR = true
			expect(GoogleMapsLoader.createUrl()).to.be.equal(baseUrl + '?sensor=true&callback=' + cb)

		it 'should create url without sensor support', ->
			GoogleMapsLoader.SENSOR = false
			expect(GoogleMapsLoader.createUrl()).to.be.equal(baseUrl + '?sensor=false&callback=' + cb)

		it 'should create url with key', ->
			GoogleMapsLoader.KEY = 'abcdefghijkl'
			expect(GoogleMapsLoader.createUrl()).to.be.equal(baseUrl + '?sensor=false&key=abcdefghijkl&callback=' + cb)

		it 'should create url with one library', ->
			GoogleMapsLoader.LIBRARIES = ['hello']
			expect(GoogleMapsLoader.createUrl()).to.be.equal(baseUrl + '?sensor=false&libraries=hello&callback=' + cb)

		it 'should create url with more libraries', ->
			GoogleMapsLoader.LIBRARIES = ['hello', 'day']
			expect(GoogleMapsLoader.createUrl()).to.be.equal(baseUrl + '?sensor=false&libraries=hello,day&callback=' + cb)

		it 'should create url with client and version', ->
			GoogleMapsLoader.CLIENT = 'buf'
			GoogleMapsLoader.VERSION = '999'
			expect(GoogleMapsLoader.createUrl()).to.be.equal(baseUrl + '?sensor=false&client=buf&v=999&callback=' + cb)
