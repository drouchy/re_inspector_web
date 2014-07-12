'use strict'

###*
 # @ngdoc function
 # @name reInspectorWebApp.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the reInspectorWebApp
###
angular.module('reInspectorWebApp')
  .controller 'AboutCtrl', ($scope, $http) ->
    $http.get("/api/version").success((data, status, headers) -> $scope.version = data.version)
