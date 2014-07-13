
angular.module('reInspectorWebApp').factory 'searchService', ($http, $q) ->
  {
    search: (query) ->
      console.log "launch search for #{query}"
      deferred = $q.defer()

      $http.get('/api/search', { params: { q: query } } ).
        success((data, status, headers) -> deferred.resolve(data)).
        error((data, status, headers) ->   deferred.reject(data))

      deferred.promise
  }
