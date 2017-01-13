module.exports = (config) ->

  config.set

    singleRun: true
    autoWath: true
    colors: true
    port: 8080
    basePath: '.'
    frameworks: ['mocha', 'chai']
    files: [
      'bower_components/angular/angular.js',
      'bower_components/angular-mocks/angular-mocks.js',
      'bower_components/restangular/dist/restangular.js',
      'bower_components/lodash/dist/lodash.min.js',
      './test/testapp.js',
      './dist/ng-flask-restless-client.js',
      './test/service.spec.js',
      './test/factory.spec.js'
    ]
    browsers: [
      'PhantomJS'
    ]
    logLevel: config.LOG_INFO
    plugins: [
      'karma-mocha',
      'karma-chai',
      'karma-coverage',
      'karma-phantomjs-launcher'
    ]
