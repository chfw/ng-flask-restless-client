'use strict'

class FlaskRestlessQueryOptionConstructor

  constructor: () ->
    @init()

  init: () =>
    @orderByOptions = []
    @filterOptions = []
    @page = undefined

  addOrderByOption: (field, direction)=>
    @orderByOptions.push(
      field: field,
      direction: direction
    )
    @

  addFilterOption: (key, op, value) =>
    @filterOptions.push
      name: key
      op: op
      val: value
    @

  addFilter: (filter) =>
    @filterOptions.push(filter)
    @

  setPageNumber: (page) =>
    @page = page
    @

  build: =>
    queryOptions = {}
    got_query = false
    if @filterOptions.length > 0
      queryOptions.filters = @filterOptions
      got_query = true
    if @orderByOptions.length > 0
      queryOptions.order_by = @orderByOptions
      got_query = true

    params = {}
    if got_query
      params.q = JSON.stringify(queryOptions)
    if @page
      params.page = @page
    @init()
    params


service = () ->
  new FlaskRestlessQueryOptionConstructor()


angular.module 'ngFlaskRestlessClient'
  .factory "ngQueryOptions", service
