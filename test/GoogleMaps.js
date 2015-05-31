(function() {

	var baseUrl = GoogleMapsLoader.URL;

	var cb = GoogleMapsLoader.WINDOW_CALLBACK_NAME;

	describe('GoogleMaps', function() {

		afterEach(function(done) {
			GoogleMapsLoader.release(function() {
				done();
			});
		});

		describe('#load', function() {

			it('should throw an error if promise style is used', function() {
				expect(function() {
					GoogleMapsLoader.load().then();
				}).to.throw(Error, 'Using promises is not supported anymore. Please take a look in new documentation and use callback instead.');
			});

			it('should load google api object', function(done) {
				GoogleMapsLoader.load(function(google) {
					expect(google).to.be.a('object');
					expect(google).to.have.keys(['maps']);
					done();
				});
			});

			it('should load google api only for first time and then use stored object', function(done) {
				var count = 0;

				GoogleMapsLoader.onLoad(function() {
					count++;
				});

				GoogleMapsLoader.load();
				GoogleMapsLoader.load();
				GoogleMapsLoader.load();
				GoogleMapsLoader.load(function() {
					expect(count).to.be.equal(1);
					done()
				});
			});
		});

		describe('#release', function() {

			it('should restore google maps package to original state and remove google api object completely and load it again', function(done) {
				GoogleMapsLoader.load(function() {
					GoogleMapsLoader.release(function() {
						expect(GoogleMapsLoader.google).to.be.null;
						expect(window.google).to.be.undefined;

						GoogleMapsLoader.load(function(google) {
							expect(google).to.be.a('object');
							expect(google).to.have.keys(['maps']);
							done();
						});
					});
				});
			});

		});

		describe('#createUrl', function() {

			it('should create url with sensor support', function() {
				GoogleMapsLoader.SENSOR = true;
				expect(GoogleMapsLoader.createUrl()).to.be.equal(baseUrl + '?sensor=true&callback=' + cb);
			});

			it('should create url without sensor support', function() {
				GoogleMapsLoader.SENSOR = false;
				expect(GoogleMapsLoader.createUrl()).to.be.equal(baseUrl + '?sensor=false&callback=' + cb);
			});

			it('should create url with key', function() {
				GoogleMapsLoader.KEY = 'abcdefghijkl';
				expect(GoogleMapsLoader.createUrl()).to.be.equal(baseUrl + '?sensor=false&key=abcdefghijkl&callback=' + cb);
			});

			it('should create url with one library', function() {
				GoogleMapsLoader.LIBRARIES = ['hello'];
				expect(GoogleMapsLoader.createUrl()).to.be.equal(baseUrl + '?sensor=false&libraries=hello&callback=' + cb);
			});

			it('should create url with more libraries', function() {
				GoogleMapsLoader.LIBRARIES = ['hello', 'day'];
				expect(GoogleMapsLoader.createUrl()).to.be.equal(baseUrl + '?sensor=false&libraries=hello,day&callback=' + cb);
			});

			it('should create url with client and version', function() {
				GoogleMapsLoader.CLIENT = 'buf';
				GoogleMapsLoader.VERSION = '999';
				expect(GoogleMapsLoader.createUrl()).to.be.equal(baseUrl + '?sensor=false&client=buf&v=999&callback=' + cb);
			});

			it('should create url with channel', function() {
				GoogleMapsLoader.CHANNEL = 'abcdefghijkl';
				expect(GoogleMapsLoader.createUrl()).to.be.equal(baseUrl + '?sensor=false&channel=abcdefghijkl&callback=' + cb);
			});

		});

	});

}).call();
