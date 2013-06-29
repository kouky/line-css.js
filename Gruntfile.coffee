module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    coffee:
      compile:
        files:
          'build/<%= pkg.name %>.js': 'src/<%= pkg.name %>.coffee'

    uglify:
      options:
        banner: '/*! <%= pkg.name %> <%= grunt.template.today("yyyy-mm-dd") %> v<%= pkg.version %> */\n'
      build:
        files:
          'build/<%= pkg.name %>.min.js': 'build/<%= pkg.name %>.js'

    cafemocha:
      test:
        src: 'test/*.coffee'
        options:
          colors: true
          ignoreLeaks: true
          ui: 'bdd'
          reporter: 'spec'
          require: ['should']


  grunt.loadNpmTasks 'grunt-contrib-uglify'

  grunt.loadNpmTasks 'grunt-contrib-coffee'

  grunt.loadNpmTasks 'grunt-cafe-mocha'

  grunt.registerTask 'default', ['cafemocha', 'coffee', 'uglify']