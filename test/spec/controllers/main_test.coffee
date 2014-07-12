'use strict'

describe 'Controller: MainCtrl', ->

  beforeEach module 'reInspectorWebApp'

  MainCtrl = {}
  scope = {}
  httpBackend = {}

  beforeEach inject ($controller, $rootScope, $httpBackend) ->
    scope = $rootScope.$new()
    httpBackend = $httpBackend

    MainCtrl = $controller 'MainCtrl', {
      $scope: scope
    }

  it 'has an undefined result array when loading', ->
    expect(scope.results).toBe undefined

  it 'has an empty query', ->
    expect(scope.query).toEqual ''

  describe 'search', ->
    it 'assigns the result of the search', ->
      results = ['REF1', 'REF2']
      httpBackend.expectGET('/api/search?q=REF1').respond(results)
      scope.query = 'REF1'

      scope.search()
      httpBackend.flush()

      httpBackend.verifyNoOutstandingExpectation()
      httpBackend.verifyNoOutstandingRequest()

    it 'assigns the result of the search', ->
      results = ['REF1', 'REF2']
      httpBackend.when('GET', '/api/search?q=REF1').respond(results)
      scope.query = 'REF1'

      scope.search()
      httpBackend.flush()

      expect(scope.results).toEqual results

    it 'resets the error when the connection is back', ->
      scope.error = 'an error message'
      httpBackend.when('GET', '/api/search?q=REF1').respond([])
      scope.query = 'REF1'

      scope.search()
      httpBackend.flush()

      expect(scope.error).toBe null

    it 'sets an error message when the backend is unreachable', ->
      httpBackend.when('GET', '/api/search?q=REF1').respond(404, 'not found')
      scope.query = 'REF1'

      scope.search()
      httpBackend.flush()

      expect(scope.error).toEqual 'Oh snap! something went wrong :-( Please try again later'
