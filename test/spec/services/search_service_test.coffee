'use strict'

xdescribe 'Service: search', ->

  beforeEach module 'reInspectorWebApp'

  service = {}
  httpBackend = {}

  beforeEach inject (searchService, $rootScope, $httpBackend) ->
    httpBackend = $httpBackend

    service = searchService

  it 'gets the service', ->
    expect(service).not.toBe undefined
    expect(service).not.toBe null

  describe 'search', ->
    beforeEach ->
      httpBackend.when('GET', '/api/search?q=query').respond(200, {foo: 'bar'})
      httpBackend.when('GET', '/api/search?q=not_found').respond(404, {error: '1'})

    it 'executes the http request', ->
      httpBackend.expectGET('/api/search?q=query').respond({foo:'bar'})

      service.search 'query'
      httpBackend.flush()

      httpBackend.verifyNoOutstandingExpectation()
      httpBackend.verifyNoOutstandingRequest()

    it 'resolves the promise when the query is executed', ->
      success = null
      failure = null

      service.search('query').then(
        (data)  -> success = data
        (error) -> failure = error
      )
      httpBackend.flush()

      expect(success).toEqual {foo: 'bar'}
      expect(failure).toBe null

    it 'rejects the promise when the query is executed', ->
      success = null
      failure = null

      service.search('not_found').then(
        (data)  -> success = data
        (error) -> failure = error
      )
      httpBackend.flush()

      expect(failure).toEqual {error: '1'}
      expect(success).toBe null
