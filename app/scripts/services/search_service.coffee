
angular.module('reInspectorWebApp').factory 'searchService', ($http, $q) ->
  {
    search: (query) ->
      console.log "launch search for #{query}"
      deferred = $q.defer()

      console.log 'mocked response';
      deferred.resolve({results: _.map(@mockResponse(), (d) -> new SearchResult(d))})#
      # $http.get('/api/search', { params: { q: query } } ).
      #   success((data, status, headers) -> deferred.resolve(data)).
      #   error((data, status, headers) ->   deferred.reject(data))

      deferred.promise

    mockResponse: ->
      [
        {
          "requested_at": "2014-01-03T14:29:00Z",
          "time_to_execute": 3430,
          "name": "post article",
          "service": {
            "name": "service 2",
            "version": "2.1.0",
            "environment": "sandbox"
          },
          "request": {
             "method": "POST",
             "path": "/articles",
             "headers": {
               "Authorization": "Bearer 1234567890",
               "Content-type": "application/json"
             },
             "body": "{ \"article\" : { \"text\": \"I should probably put a long text\", \"author\": \"me\" } }"
          },
          "response": {
             "status": 201,
             "headers": {
               "content-type": "application/json"
             },
             "body": "{ \"article\": { \"id\": \"1234567890\", \"status\": \"created\" } }"
          }
        },
        {
          "requested_at": "2014-01-03T14:30:00Z",
          "name": "comment article",
          "time_to_execute": 1230,
          "service": {
            "name": "service 1",
            "version": "0.0.1",
            "environment": "sandbox"
          },
          "request": {
             "method": "POST",
             "path": "/articles/1234567890/comments",
             "headers": {
               "Authorization": "Bearer 1234567890",
               "Content-type": "application/json"
             },
             "body": "{ \"comment\" : { \"comment\": \"this is a comment\", \"article_id\": \"1234567890\" } }"
          },
          "response": {
             "status": 404,
             "headers": {
               "content-type": "application/json"
             },
             "body": "{ \"comment\": { \"id\": \"24C43\", \"status\": \"submitted\" } }"
          }
        },
        {
          "requested_at": "2014-01-03T14:32:00Z",
          "name": "delete article",
          "time_to_execute": 1230,
          "service": {
            "name": "service 3",
            "version": "0.0.1",
            "environment": "sandbox"
          },
          "request": {
             "method": "delete",
             "path": "/articles/1234567890",
             "headers": {
               "Authorization": "Bearer 1234567890",
               "Content-type": "application/json"
             }
           }
          "response": {
             "status": 500,
             "headers": {
               "content-type": "application/json"
             },
             "body": "something went wrong"
          }
        }
      ]
  }
