###
grunt-styledocco
https://github.com/weareinteractive/grunt-styledocco

Copyright (c) 2013 We Are Interactive
Licensed under the MIT license.
###
module.exports = (grunt) ->
  "use strict"

  spawn = require('cross-spawn')

  # Please see the grunt documentation for more information regarding task and
  # helper creation: https://github.com/cowboy/grunt/blob/master/docs/toc.md

  # -----------------------------------------------------------------------------------------------
  # ~ Tasks
  # -----------------------------------------------------------------------------------------------

  grunt.registerMultiTask "styledocco", "Generate a style guide from your stylesheets.", ->
    done = @async()

    options = @options(
      name: "Styledocco"
      cmd: "styledocco"
      include: null
      exclude: null
      preprocessor: null
    )

    @files.forEach (file) ->
      args = []
      command =
        cmd: options.cmd
        args: args

      args.push file.src[0]
      args.push "--out", file.dest
      args.push "--no-minify" if options["no-minify"]?
      args.push "--name", options.name if options.name?
      args.push "--preprocessor", options.preprocessor  if options.preprocessor?
      args.push "--verbose" if options.verbose?
      args.push "--theme", options.theme if options.theme?
      args.push "--isolate" if options.isolate?
      args.push "--only", options.only if options.only?

      if options.exclude?
        options.exclude.forEach (value) ->
          args.push "--exclude", value

      if options.include?
        options.include.forEach (value) ->
          args.push "--include", value

      process = spawn command.cmd, command.args, { stdio: 'inherit' }
      grunt.verbose.ok "`styledocco " + command.args.join(" ") + "` was initiated."

      process.on "close", (code) -> done()
