'use strict';
angular.module('ngFlaskRestlessClient', ['restangular']);

var factory,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

factory = function(Restangular) {
  var FlaskRestlessAPIFactory;
  FlaskRestlessAPIFactory = (function() {
    function FlaskRestlessAPIFactory(name) {
      this.deleteOne = bind(this.deleteOne, this);
      this.editOne = bind(this.editOne, this);
      this.createOne = bind(this.createOne, this);
      this.findOne = bind(this.findOne, this);
      this.search = bind(this.search, this);
      this.findAll = bind(this.findAll, this);
      this.name = name;
    }

    FlaskRestlessAPIFactory.prototype.findAll = function() {
      return Restangular.one(this.name).get();
    };

    FlaskRestlessAPIFactory.prototype.search = function(params) {
      return Restangular.one(this.name).get(params);
    };

    FlaskRestlessAPIFactory.prototype.findOne = function(id) {
      return Restangular.one(this.name, id).get();
    };

    FlaskRestlessAPIFactory.prototype.createOne = function(data) {
      return Restangular.all(this.name).post(data);
    };

    FlaskRestlessAPIFactory.prototype.editOne = function(data) {
      return this.findOne(data.id).then((function(_this) {
        return function(element) {
          return Restangular.one(_this.name, data.id).customPUT(data);
        };
      })(this));
    };

    FlaskRestlessAPIFactory.prototype.deleteOne = function(id) {
      return Restangular.one(this.name, id).remove();
    };

    return FlaskRestlessAPIFactory;

  })();
  return FlaskRestlessAPIFactory;
};

angular.module('ngFlaskRestlessClient').factory('ngApiEndPoint', ['Restangular', factory]);

'use strict';
var FlaskRestlessQueryOptionConstructor, service,
  bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

FlaskRestlessQueryOptionConstructor = (function() {
  function FlaskRestlessQueryOptionConstructor() {
    this.build = bind(this.build, this);
    this.setPageNumber = bind(this.setPageNumber, this);
    this.addFilter = bind(this.addFilter, this);
    this.addFilterOption = bind(this.addFilterOption, this);
    this.addOrderByOption = bind(this.addOrderByOption, this);
    this.init = bind(this.init, this);
    this.init();
  }

  FlaskRestlessQueryOptionConstructor.prototype.init = function() {
    this.orderByOptions = [];
    this.filterOptions = [];
    return this.page = void 0;
  };

  FlaskRestlessQueryOptionConstructor.prototype.addOrderByOption = function(field, direction) {
    this.orderByOptions.push({
      field: field,
      direction: direction
    });
    return this;
  };

  FlaskRestlessQueryOptionConstructor.prototype.addFilterOption = function(key, op, value) {
    this.filterOptions.push({
      name: key,
      op: op,
      val: value
    });
    return this;
  };

  FlaskRestlessQueryOptionConstructor.prototype.addFilter = function(filter) {
    this.filterOptions.push(filter);
    return this;
  };

  FlaskRestlessQueryOptionConstructor.prototype.setPageNumber = function(page) {
    this.page = page;
    return this;
  };

  FlaskRestlessQueryOptionConstructor.prototype.build = function() {
    var got_query, params, queryOptions;
    queryOptions = {};
    got_query = false;
    if (this.filterOptions.length > 0) {
      queryOptions.filters = this.filterOptions;
      got_query = true;
    }
    if (this.orderByOptions.length > 0) {
      queryOptions.order_by = this.orderByOptions;
      got_query = true;
    }
    params = {};
    if (got_query) {
      params.q = JSON.stringify(queryOptions);
    }
    if (this.page) {
      params.page = this.page;
    }
    this.init();
    return params;
  };

  return FlaskRestlessQueryOptionConstructor;

})();

service = function() {
  return new FlaskRestlessQueryOptionConstructor();
};

angular.module('ngFlaskRestlessClient').factory("ngQueryOptions", service);
