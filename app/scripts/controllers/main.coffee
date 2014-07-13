'use strict'

###*
 # @ngdoc function
 # @name reInspectorWebApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the reInspectorWebApp
###
angular.module('reInspectorWebApp')
  .controller 'MainCtrl', ($scope, $http, searchService) ->
    $scope.query = ''

    $scope.search = ->
      console.log("searching '#{$scope.query}'")
      searchService.search($scope.query).then(
        (data)  -> $scope.results = data ; $scope.error = null
        (error) -> $scope.error = 'Oh snap! something went wrong :-( Please try again later'
      )
