
angular.module('reInspectorWebApp').factory 'searchService', ($http, $q) ->
  {
    search: (path) ->
      console.log "loading path #{path}"
      deferred = $q.defer()

      $http.get(path).
        success((data, status, headers) => deferred.resolve(@transformData(data))).
        error((data, status, headers)   => deferred.reject(data))

      deferred.promise

    transformData: (data) ->
      {
        results: _.map(data.results, (entry) -> new SearchResult(entry)),
        pagination: data.pagination
      }
  }
