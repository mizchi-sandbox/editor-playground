gulp = require('gulp')
downloadatomshell = require('gulp-download-atom-shell')

gulp.task 'downloadatomshell', (cb) ->
  downloadatomshell
    version: '0.18.2'
    outputDir: 'binaries'
  , cb

gulp.task 'default', ['downloadatomshell']

