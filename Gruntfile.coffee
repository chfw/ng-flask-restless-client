'use strict'


module.exports = (grunt) ->
  grunt.initConfig
    pkg:
      grunt.file.readJSON 'package.json'

    coffeelint:
      default: ['src/*.coffee']
    coffee:
      app:
        options:
          bare: true
        files: 
          'dist/ng-flask-restless-client.js': ['src/module.coffee', 'src/factory.coffee', 'src/service.coffee']
      test:
        options:
          bare: true
        files:
          'test/service.spec.js': 'src/service.spec.coffee'
          'test/factory.spec.js': 'src/factory.spec.coffee'

  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-coffeelint'

  grunt.registerTask 'default', ['coffeelint', 'coffee:app']
  grunt.registerTask 'test', ['coffee:app', 'coffee:test']
