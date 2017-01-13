factory = (Restangular) ->
  # closure function to inject Restangular
  class FlaskRestlessAPIFactory
    constructor: (name) ->
      @name = name
  
    findAll: =>
      Restangular.one(@name).get()
  
    search: (params) =>
      Restangular.one(@name).get params
  
    findOne: (id) =>
      Restangular.one(@name, id).get()
  
    createOne: (data) =>
      Restangular.all(@name).post(data)
  
    editOne: (data) =>
      @findOne(data.id).then (element)=>
        Restangular.one(@name, data.id).customPUT(data)
  
    deleteOne: (id) =>
      Restangular.one(@name, id).remove()

  FlaskRestlessAPIFactory

angular.module 'ngFlaskRestlessClient'
  .factory 'ngApiEndPoint', ['Restangular', factory]
