'use strict'

describe 'Service: search', ->

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
      httpBackend.when('GET', '/api/search?q=query').respond(200, {results: [{foo: 'bar'}]})
      httpBackend.when('GET', '/api/search?q=not_found').respond(404, {error: '1'})

    it 'executes the http request', ->
      httpBackend.expectGET('/api/search?q=query').respond({foo:'bar'})

      service.search '/api/search?q=query'
      httpBackend.flush()

      httpBackend.verifyNoOutstandingExpectation()
      httpBackend.verifyNoOutstandingRequest()

    it 'resolves the promise when the query is executed', ->
      success = null
      failure = null

      service.search('/api/search?q=query').then(
        (data)  -> success = data
        (error) -> failure = error
      )
      httpBackend.flush()

      expect(success).not.toBe null
      expect(failure).toBe null

    it 'transforms the result to search result', ->
      success = null
      failure = null

      service.search('/api/search?q=query').then(
        (data)  -> success = data
      )
      httpBackend.flush()

      expect(success.results[0].isCollapsed).toBe false

    it 'rejects the promise when the query is executed', ->
      success = null
      failure = null

      service.search('/api/search?q=not_found').then(
        (data)  -> success = data
        (error) -> failure = error
      )
      httpBackend.flush()

      expect(failure).toEqual {error: '1'}
      expect(success).toBe null
