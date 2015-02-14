gulp = require 'gulp'
jade = require 'gulp-jade'
webpack = require 'gulp-webpack'
conn = require 'gulp-connect'
deploy = require 'gulp-gh-pages'

paths =
  jade: 'src/*.jade'
  vue: 'src/**/*.vue'
  dest: 'build/'

gulp.task 'jade', ->
  gulp.src paths.jade
    .pipe jade()
    .pipe gulp.dest(paths.dest)

gulp.task 'webpack', ->
  gulp.src 'src/index.coffee'
    .pipe webpack
      resolve:
        extensions: ['', '.coffee', '.vue', '.js']
      module:
        loaders: [
          test: /\.coffee$/
          loader: 'coffee-loader'
        ,
          test: /\.vue$/
          loader: 'vue'
        ]
      output:
        filename: 'index.js'
    .pipe gulp.dest paths.dest

gulp.task 'default', ['jade', 'webpack']
gulp.task 'watch', ['default'], ->
  gulp.watch paths.jade, ['jade']
  gulp.watch paths.vue, ['webpack']
  conn.server
    root: 'build'

gulp.task 'deploy', ['default'], ->
  gulp.src './build/*'
    .pipe deploy
      cacheDir: 'tmp'
