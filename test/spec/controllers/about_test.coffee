'use strict'

describe 'Controller: AboutCtrl', ->

  # load the controller's module
  beforeEach module 'reInspectorWebApp'

  AboutCtrl = {}
  scope = {}
  mockBackend = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope, $httpBackend) ->
    mockBackend = $httpBackend
    scope = $rootScope.$new()

    mockBackend.expectGET('/api/version').respond({version: {backend: "0.0.2", app: "0.0.3"}})

    AboutCtrl = $controller 'AboutCtrl', {
      $scope: scope
    }

  it 'queries the backend for the version', ->
    mockBackend.flush()

    mockBackend.verifyNoOutstandingExpectation()
    mockBackend.verifyNoOutstandingRequest()

  it 'sets the version in the scope', ->
    mockBackend.flush()

    version = scope.version

    expect(version).not.toBe(null)
    expect(version).not.toBe(undefined)

  it 'sets the version with the backend values', ->
    mockBackend.flush()

    version = scope.version

    expect(version.backend).toEqual "0.0.2"
