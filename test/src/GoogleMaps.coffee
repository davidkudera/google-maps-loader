describe 'GoogleMaps', ->

	describe '#load()', ->

		afterEach( (done) ->
			GoogleMapsLoader.release( ->
				done()
			)
		)

		it 'should throw an error if promise style is used', ->
			expect( -> GoogleMapsLoader.load().then()).to.throw(Error, 'Using promises is not supported anymore. Please take a look in new documentation and use callback instead.')

		it 'should load google api object', (done) ->
			GoogleMapsLoader.load( (google) ->
				expect(google).to.be.a('object')
				expect(google).to.have.keys(['maps'])
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