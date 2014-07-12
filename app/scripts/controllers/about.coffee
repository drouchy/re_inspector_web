'use strict'

###*
 # @ngdoc function
 # @name reInspectorWebApp.controller:AboutCtrl
 # @description
 # # AboutCtrl
 # Controller of the reInspectorWebApp
###
angular.module('reInspectorWebApp')
  .controller 'AboutCtrl', ($scope) ->
    $scope.awesomeThings = [
      'HTML5 Boilerplate'
      'AngularJS'
      'Karma'
    ]
