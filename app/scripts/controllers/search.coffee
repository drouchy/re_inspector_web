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

    $scope.search = ->
      $location.search("q", $scope.query)
      $location.path("/search")

    $scope.executeSearch = ->
      console.log("searching '#{$scope.query}'")
      searchService.search($scope.query).then(
        (data)  -> $scope.results = data.results ; $scope.error = null
        (error) -> $scope.error = 'Oh snap! something went wrong :-( Please try again later'
      )

    $scope.executeSearch()