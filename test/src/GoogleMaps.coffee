describe 'GoogleMaps', ->

	describe '#load()', ->

		it.skip 'should throw an error if promise style is used', ->
			expect( -> GoogleMapsLoader.load().then()).to.throw(Error, 'Using promises is not supported anymore. Please take a look in new documentation and use callback instead.')

		it 'should load google api object', (done) ->
			GoogleMapsLoader.load( (google) ->
				expect(google).to.be.a('object')
				expect(google).to.have.keys(['maps'])
				done()
			)