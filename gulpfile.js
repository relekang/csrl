var gulp = require('gulp'),
    uglify = require('gulp-uglify'),
    coffee = require('gulp-coffee'),
    notify = require('gulp-notify'),
    rl = require('./gulp-removelines');

gulp.task('compile', function() {
  return gulp.src('src/learner.coffee')
    .pipe(coffee({bare: true}))
    .pipe(rl({'filters': [/^localStorage = /]}))
    .pipe(uglify())
    .pipe(gulp.dest('./dist/'))
    .pipe(notify({
      title: 'Gulp: rank-learning.js',
      message: 'Compiled files'
    }));
});

gulp.task('default', ['compile']);

gulp.task('watch', function () {
  gulp.watch('src/*.coffee', ['compile']);
});


