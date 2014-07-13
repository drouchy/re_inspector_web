class @SearchResult
  constructor: (http_data) ->
    @isCollapsed = false
    @data = http_data

  toggle: ->
    @isCollapsed = !@isCollapsed

  responseType: ->
    status = @data.response.status
    switch
      when status < 400 then 'bs-callout-info'
      when status < 500 then 'bs-callout-warning'
      else 'bs-callout-danger'

  responseBody: ->

  url: ->
    "#{@data.request.method.toUpperCase()} #{@data.request.path}"
