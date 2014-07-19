'use strict'

describe 'Controller: SearchCtrl', ->

  beforeEach module 'reInspectorWebApp'

  MainCtrl = {}
  scope = {}
  deferred = {}
  promise = {}
  service = {}
  routeParams = {}
  location = {}

  beforeEach inject ($controller, $rootScope, searchService, $q, $location, $routeParams) ->
    $routeParams['q'] = 'to_search'
    $location.search('q', 'to_search')

    buildPromise($q, searchService)

    scope = $rootScope.$new()
    location = $location

    MainCtrl = $controller 'SearchCtrl', {$scope: scope}

  it 'has an undefined result array when loading', ->
    expect(scope.results).toBe undefined

  it 'has a query set to the q params', ->
    expect(scope.query).toEqual 'to_search'


  describe 'search', ->
    it 'redirects to the search controller', ->
      scope.query = 'foo_bar'

      scope.search()

      expect(location.path()).toEqual "/search"

    it 'applies the search query in the parameters', ->
      scope.query = 'foo_bar'

      scope.search()

      expect(location.$$url).toEqual "/search?q=foo_bar"

  describe 'search execution', ->
    it 'searches the query', ->
      expect(service.search).toHaveBeenCalledWith('to_search')

    it 'assigns the result of the search', ->
      results = ['REF1', 'REF2']

      deferred.resolve({results: results})
      scope.$apply()

      expect(scope.results).toBe results

    it 'resets the error when the connection is back', ->
      scope.error = 'an error message'

      deferred.resolve('')
      scope.$apply()

      expect(scope.error).toBe null

    it 'sets an error message when the search fails', ->
      deferred.reject('error')
      scope.$apply()

      expect(scope.error).toEqual 'Oh snap! something went wrong :-( Please try again later'

  buildPromise = (q, searchService) ->
    deferred = q.defer()
    promise = deferred.promise

    service = searchService
    spyOn(searchService, 'search').andReturn(promise)
