gulp    = require 'gulp'
concat  = require 'gulp-concat'
coffee  = require 'gulp-coffee'
iife    = require 'gulp-iife-wrap'
plumber = require 'gulp-plumber'

gulp.task 'default', ['build', 'watch'], ->

gulp.task 'build', ->
  dependencies = [{global: 'document', native:  true},
                  {global: '$',        require: 'jquery'}]
  gulp.src('source/jquery-transition.coffee')
    .pipe plumber()
    .pipe iife({dependencies})
    .pipe concat('jquery-transition.coffee')
    .pipe gulp.dest('build')
    .pipe coffee()
    .pipe concat('jquery-transition.js')
    .pipe gulp.dest('build')

gulp.task 'watch', ->
  gulp.watch 'source/**/*', ['build']
