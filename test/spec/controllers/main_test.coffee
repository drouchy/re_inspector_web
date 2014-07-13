'use strict'

xdescribe 'Controller: MainCtrl', ->

  beforeEach module 'reInspectorWebApp'

  MainCtrl = {}
  scope = {}
  deferred = {}
  promise = {}
  service = {}

  beforeEach inject ($controller, $rootScope, searchService, $q) ->
    scope = $rootScope.$new()

    MainCtrl = $controller 'MainCtrl', {
      $scope: scope
    }

    deferred = $q.defer()
    promise = deferred.promise

    service = searchService
    spyOn(searchService, 'search').andReturn(promise)

  it 'has an undefined result array when loading', ->
    expect(scope.results).toBe undefined

  it 'has an empty query', ->
    expect(scope.query).toEqual ''

  describe 'search', ->
    it 'searches the query', ->
      scope.query = 'REF1'

      scope.search()

      expect(service.search).toHaveBeenCalledWith('REF1')

    it 'assigns the result of the search', ->
      results = ['REF1', 'REF2']

      scope.search()
      deferred.resolve(results)
      scope.$apply()

      expect(scope.results).toBe results

    it 'resets the error when the connection is back', ->
      scope.error = 'an error message'

      scope.search()
      deferred.resolve('')
      scope.$apply()

      expect(scope.error).toBe null

    it 'sets an error message when the search fails', ->
      scope.search()

      deferred.reject('error')
      scope.$apply()

      expect(scope.error).toEqual 'Oh snap! something went wrong :-( Please try again later'
