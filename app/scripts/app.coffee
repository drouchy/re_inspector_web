'use strict'

###*
 # @ngdoc overview
 # @name reInspectorWebApp
 # @description
 # # reInspectorWebApp
 #
 # Main module of the application.
###
angular
  .module('reInspectorWebApp', [
    'ngAnimate',
    'ngCookies',
    'ngResource',
    'ngRoute',
    'ngSanitize',
    'ngTouch',
    'ui.bootstrap',
    'hljs'
  ])
  .config ($routeProvider) ->
    $routeProvider
      .when '/',
        templateUrl: '/views/main.html'
        controller: 'MainCtrl'
      .when '/search',
        templateUrl: '/views/search.html'
        controller: 'SearchCtrl'
      .when '/about',
        templateUrl: '/views/about.html'
        controller: 'AboutCtrl'
      .otherwise
        redirectTo: '/'
