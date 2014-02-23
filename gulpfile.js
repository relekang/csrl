var gulp = require('gulp'),
    uglify = require('gulp-uglify'),
    coffee = require('gulp-coffee'),
    notify = require('gulp-notify'),
    rl = require('gulp-remove-lines');

gulp.task('build', function() {
  return gulp.src('src/learner.coffee')
    .pipe(coffee({bare: true}))
    .pipe(rl({'filters': [/^localStorage = /]}))
    //.pipe(uglify())
    .pipe(gulp.dest('./dist/'))
    .pipe(notify({
      title: 'Gulp: rank-learning.js',
      message: 'Compiled files'
    }));
});
gulp.task('build-demo', function() {
  return gulp.src('demo/app.coffee')
    .pipe(coffee({bare: true}))
    //.pipe(uglify())
    .pipe(gulp.dest('./demo/dist'))
    .pipe(notify({
      title: 'Gulp: rank-learning.js',
      message: 'Compiled files'
    }));
});

gulp.task('default', ['build']);

gulp.task('watch', function () {
  gulp.watch('src/*.coffee', ['build']);
});
gulp.task('watch-demo', function () {
  gulp.watch('**/*.coffee', ['build', 'build-demo']);
});



