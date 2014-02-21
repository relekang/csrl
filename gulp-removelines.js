'use strict';
var es = require('event-stream'),
  gutil = require('gulp-util');

module.exports = function (opt) {
  function modifyFile(file) {
    if (file.isNull()) return this.emit('data', file); // pass along
    if (file.isStream()) return this.emit('error', new Error("gulp-removelines: Streaming not supported"));
    console.log(opt);
    var str = file.contents.toString('utf8');
    var line, _i, _j, _len, lines;

    lines = str.split('\n');
    for (_i = 0; _i < lines.length; _i++) {
      for (_j = 0; _j < opt.filters.length; _j++) {
        if(lines[_i].match(opt.filters[_j])){
          delete lines[_i]
        }
      }  
    }
    str = lines.join('\n')

    file.contents = new Buffer(str);
    this.emit('data', file);
  }

  return es.through(modifyFile);
};