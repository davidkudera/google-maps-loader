(function() {

	var baseUrl = GoogleMapsLoader.URL;

	var cb = GoogleMapsLoader.WINDOW_CALLBACK_NAME;
	var googleVersion = '3.31';

	describe('GoogleMaps', function() {

		beforeEach(function() {
			GoogleMapsLoader.makeMock();
		});

		afterEach(function(done) {
			GoogleMapsLoader.release(function() {
				done();
			});
		});

		describe('#load', function() {

			it('should load google api object', function(done) {
				GoogleMapsLoader.load(function(google) {
					expect(google).to.be.a('object');
					expect(GoogleMapsLoader.isLoaded()).to.be.true;
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
					expect(GoogleMapsLoader.isLoaded()).to.be.true;

					GoogleMapsLoader.release(function() {
						expect(GoogleMapsLoader.isLoaded()).to.be.false;

						GoogleMapsLoader.makeMock();
						GoogleMapsLoader.load(function() {
							expect(GoogleMapsLoader.isLoaded()).to.be.true;
							done();
						});
					});
				});
			});

		});

		describe('#createUrl', function() {

			it('should create url with key', function() {
				GoogleMapsLoader.KEY = 'abcdefghijkl';
				expect(GoogleMapsLoader.createUrl()).to.be.equal(baseUrl + '?callback=' + cb + '&key=abcdefghijkl' + '&v=' + googleVersion);
			});

			it('should create url with one library', function() {
				GoogleMapsLoader.LIBRARIES = ['hello'];
				expect(GoogleMapsLoader.createUrl()).to.be.equal(baseUrl + '?callback=' + cb + '&libraries=hello' + '&v=' + googleVersion);
			});

			it('should create url with more libraries', function() {
				GoogleMapsLoader.LIBRARIES = ['hello', 'day'];
				expect(GoogleMapsLoader.createUrl()).to.be.equal(baseUrl + '?callback=' + cb + '&libraries=hello,day' + '&v=' + googleVersion);
			});

			it('should create url with version', function() {
				GoogleMapsLoader.VERSION = '999';
				expect(GoogleMapsLoader.createUrl()).to.be.equal(baseUrl + '?callback=' + cb + '&v=999');
			});

			it('should create url with client', function() {
				GoogleMapsLoader.CLIENT = 'buf';
				expect(GoogleMapsLoader.createUrl()).to.be.equal(baseUrl + '?callback=' + cb + '&client=buf' + '&v=' + googleVersion);
			});

			it('should create url with channel', function() {
				GoogleMapsLoader.CHANNEL = 'abcdefghijkl';
				expect(GoogleMapsLoader.createUrl()).to.be.equal(baseUrl + '?callback=' + cb + '&channel=abcdefghijkl' + '&v=' + googleVersion);
			});

			it('should create url with language', function() {
				GoogleMapsLoader.LANGUAGE = 'fr';
				expect(GoogleMapsLoader.createUrl()).to.be.equal(baseUrl + '?callback=' + cb + '&language=fr' + '&v=' + googleVersion);
			});

			it('should create url with region', function() {
				GoogleMapsLoader.REGION = 'GB';
				expect(GoogleMapsLoader.createUrl()).to.be.equal(baseUrl + '?callback=' + cb + '&region=GB' + '&v=' + googleVersion);
			});
		});

	});

}).call();
