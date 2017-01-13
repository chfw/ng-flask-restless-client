describe 'FlaskRestlessAPIEndPoint', ->
  # test variables
  repo = undefined
  fakeName = 'test'
  fakeResponse =
    hello: 'world'

  # test preparation
  beforeEach module('ngFlaskRestlessClient')
  beforeEach inject (ngApiEndPoint) ->
    repo = new ngApiEndPoint(fakeName)

  afterEach inject ($httpBackend, $rootScope) ->
    $httpBackend.flush()
    $rootScope.$apply()

  it 'should do findall', inject ($httpBackend) ->
    url = '/' + fakeName
    $httpBackend.expectGET(url).respond(fakeResponse)
    repo.findAll().then (response) ->
      assert.equal(response.hello, fakeResponse.hello)

  it 'should do findone', inject ($httpBackend) ->
    fakeId = 'id'
    $httpBackend.expectGET('/'+fakeName+'/'+fakeId)
      .respond(fakeResponse)
    repo.findOne(fakeId).then (response) ->
      assert.equal(response.hello, fakeResponse.hello)

  it 'should do editone', inject ($httpBackend) ->
    data =
      id: 'id'
    $httpBackend.expectGET('/'+fakeName+'/'+data['id'])
      .respond(fakeResponse)
    $httpBackend.expectPUT('/'+fakeName+'/'+data['id'])
      .respond(fakeResponse)
    repo.editOne(data).then (response) ->
      assert.equal(response.hello, fakeResponse.hello)

  it 'should do deleteone', inject ($httpBackend) ->
    fakeId = 'id'
    $httpBackend.expectDELETE('/'+fakeName+'/'+fakeId)
      .respond(fakeResponse)
    repo.deleteOne(fakeId).then (response) ->
      assert.equal(response.hello, fakeResponse.hello)

  it 'should do createone', inject ($httpBackend) ->
    data =
      id: 'id'
    $httpBackend.expectPOST('/'+fakeName)
      .respond(fakeResponse)
    repo.createOne(data).then (response) ->
      assert.equal(response.hello, fakeResponse.hello)

  it 'should do search', inject ($httpBackend, ngQueryOptions) ->
    options = ngQueryOptions
      .setPageNumber(11)
      .build()
    searchUrl = '/' + fakeName
    searchUrl = searchUrl + '?page=11'
    $httpBackend.expectGET(searchUrl)
      .respond(fakeResponse)
    repo.search(options).then (response) ->
      assert.equal(response.hello, fakeResponse.hello)
