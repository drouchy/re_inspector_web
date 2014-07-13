
angular.module('reInspectorWebApp').factory 'searchService', ($http, $q) ->
  {
    search: (query) ->
      console.log "launch search for #{query}"
      deferred = $q.defer()

      console.log 'mocked response';
      $http.get('/api/search', { params: { q: query } } ).
        success((data, status, headers) => deferred.resolve(@transformData(data))).
        error((data, status, headers)   =>   deferred.reject(data))

      deferred.promise

    transformData: (data) ->
      {
        results: _.map data.results, (entry) -> new SearchResult(entry)
      }
