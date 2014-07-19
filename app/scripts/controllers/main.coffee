'use strict'

###*
 # @ngdoc function
 # @name reInspectorWebApp.controller:MainCtrl
 # @description
 # # MainCtrl
 # Controller of the reInspectorWebApp
###
angular.module('reInspectorWebApp')
  .controller 'MainCtrl', ($scope, $http, $location, searchService) ->
    $scope.query = ''

    $scope.search = ->
      console.log("searching '#{$scope.query}'")
      $location.search("q", $scope.query)
      $location.path("/search")
