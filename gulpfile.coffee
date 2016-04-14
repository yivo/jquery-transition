require('gulp-lazyload')
  gulp:       'gulp'
  connect:    'gulp-connect'
  concat:     'gulp-concat'
  coffee:     'gulp-coffee'
  preprocess: 'gulp-preprocess'
  iife:       'gulp-iife-wrap'
  uglify:     'gulp-uglify'
  rename:     'gulp-rename'
  del:        'del'
  plumber:    'gulp-plumber'
  replace:    'gulp-replace'

gulp.task 'default', ['build', 'watch'], ->

dependencies = [{require: 'jquery', global: '$'}, {global: 'document', native: yes}]

gulp.task 'build', ->
  gulp.src('source/jquery-transition.coffee')
  .pipe plumber()
  .pipe preprocess()
  .pipe iife({dependencies})
  .pipe concat('jquery-transition.coffee')
  .pipe gulp.dest('build')
  .pipe coffee()
  .pipe concat('jquery-transition.js')
  .pipe gulp.dest('build')

gulp.task 'build-min', ['build'], ->
  gulp.src('build/jquery-transition.js')
  .pipe uglify()
  .pipe rename('jquery-transition.min.js')
  .pipe gulp.dest('build')

gulp.task 'watch', ->
  gulp.watch 'source/**/*', ['build']