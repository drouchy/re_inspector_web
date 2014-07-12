'use strict'

###*
 # @ngdoc function
 # @name reInspectorWebApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the reInspectorWebApp
###
angular.module('reInspectorWebApp')
  .controller 'MainCtrl', ($scope, $http) ->
    $scope.query = ''

    $scope.search = ->
      console.log("searching #{$scope.query}")
      $http.get('/api/search', { params: { q: $scope.query }}).
        success((data, status, headers) -> $scope.results = data; $scope.error = null).
        error((data, status, headers) -> $scope.error = 'Oh snap! something went wrong :-( Please try again later')
