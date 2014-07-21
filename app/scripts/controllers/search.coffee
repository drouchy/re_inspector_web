'use strict'

###*
 # @ngdoc function
 # @name reInspectorWebApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the reInspectorWebApp
###
angular.module('reInspectorWebApp')
  .controller 'SearchCtrl', ($scope, $http, $location, $routeParams, searchService) ->
    $scope.query = $routeParams.q
    $scope.noResults = false

    $scope.search = ->
      $location.search("q", $scope.query)
      $location.path("/search")
      $scope.executeSearch()

    $scope.executeSearch = ->
      console.log "searching '#{$scope.query}'"
      $scope.searching = true
      searchService.search($scope.query).then(
        (data)  ->
          $scope.results = data.results
          $scope.noResults = data.results.length == 0
          $scope.searching = false
        (error) ->
          $scope.noResults = false
          $scope.searching = false
      )

    $scope.executeSearch()