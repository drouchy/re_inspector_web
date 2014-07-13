'use strict'

describe 'Model: SearchResult', ->

  data = {}
  beforeEach ->
    data = {
      request: {
        method: 'GET'
        path: '/uri_1'
      }
      response: {
        body: '{"a":1, "foo":"bar"}'
        status: 200
      }
    }

  describe '#constructor', ->
    it 'is not collapsed', ->
      subject = new SearchResult(data)

      expect(subject.isCollapsed).toBe false

    it 'keeps the data', ->
      subject = new SearchResult(data)

      expect(subject.data).toBe data

  describe '#url', ->
    it 'concatenates the method & path', ->
      subject = new SearchResult(data)

      expect(subject.url()).toEqual 'GET /uri_1'

    it 'upcase the method', ->
      data.request.method = 'get'

      subject = new SearchResult(data)

      expect(subject.url()).toEqual 'GET /uri_1'

  describe '#responseType', ->
    it 'returns "bs-callout-info" for a 2xx', ->
      data.response.status = 201

      subject = new SearchResult(data)

      expect(subject.responseType()).toEqual 'bs-callout-info'

    it 'returns "bs-callout-info" for a 3xx', ->
      data.response.status = 302

      subject = new SearchResult(data)

      expect(subject.responseType()).toEqual 'bs-callout-info'


    it 'returns "bs-callout-warning" for a 4xx', ->
      data.response.status = 404

      subject = new SearchResult(data)

      expect(subject.responseType()).toEqual 'bs-callout-warning'


    it 'returns "bs-callout-danger" for a 5xx', ->
      data.response.status = 500

      subject = new SearchResult(data)

      expect(subject.responseType()).toEqual 'bs-callout-danger'

  describe '#toggle', ->
    it 'collapses the result when expanded', ->
      subject = new SearchResult()
      subject.isCollapsed = false

      subject.toggle()

      expect(subject.isCollapsed).toBe true

    it 'expand the result when collapsed', ->
      subject = new SearchResult()
      subject.isCollapsed = true

      subject.toggle()

      expect(subject.isCollapsed).toBe false
