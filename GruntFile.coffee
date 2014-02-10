module.exports = (grunt) ->

  # Project configuration
  #
  grunt.initConfig
    coffee:
      default:
        files: [
            expand: true         # Enable dynamic expansion.
            cwd: 'src/'          # Src matches are relative to this path.
            src: ['**/*.coffee'] # Actual pattern(s) to match.
            dest: 'lib/'         # Destination path prefix.
            ext: '.js'           # Dest filepaths will have this extension.
        ]

    watch:
        src:
            files: ['src/**/*.coffee']
            tasks: ['coffee']

    # These plugins provide the necessary tasks
    #
    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-watch'

    # Default tasks
    #
    grunt.registerTask 'default', [ 'coffee' ]