var Learner, localStorage, root, _ref;



Learner = (function() {
  function Learner() {}

  Learner.storage_key = 'learnerstats';

  Learner.reset = function() {
    return localStorage.removeItem(this.storage_key);
  };

  Learner.prototype.save = function(stats) {
    return localStorage.setItem(Learner.storage_key, JSON.stringify(stats));
  };

  Learner.prototype.load = function() {
    var data, stats;
    data = localStorage.getItem(Learner.storage_key);
    if (!data) {
      stats = {
        terms: {}
      };
    } else {
      stats = JSON.parse(data);
    }
    return stats;
  };

  Learner.prototype.getLastSaved = function() {
    return new Date(this.load().lastSaved);
  };

  Learner.prototype.getTermWeight = function(term) {
    var error;
    try {
      return this.load().terms[term].weight;
    } catch (_error) {
      error = _error;
      return 0;
    }
  };

  Learner.prototype.updateTermWeight = function(term, weight) {
    var stats;
    stats = this.load();
    if (term in stats.terms) {
      stats.terms[term].weight += weight;
    } else {
      stats.terms[term] = {
        'weight': weight
      };
    }
    stats.lastSaved = new Date;
    return this.save(stats);
  };

  Learner.prototype.calculateScore = function(termScores) {
    var key, score, value;
    score = 0;
    for (key in termScores) {
      value = termScores[key];
      score += value * this.getTermWeight(key);
    }
    return score;
  };

  Learner.prototype.rank = function(list) {
    var item, _i, _len;
    for (_i = 0, _len = list.length; _i < _len; _i++) {
      item = list[_i];
      item.score = this.calculateScore(item.termScores);
    }
    list.sort(function(a, b) {
      if (a.score > b.score) {
        return -1;
      }
      if (a.score < b.score) {
        return +1;
      }
      return 0;
    });
    return list;
  };

  Learner.prototype.reportClick = function(item) {
    var key, maxScore, value, _ref1, _results;
    maxScore = Math.max.apply(this, (function() {
      var _ref1, _results;
      _ref1 = item.termScores;
      _results = [];
      for (key in _ref1) {
        value = _ref1[key];
        _results.push(value);
      }
      return _results;
    })());
    _ref1 = item.termScores;
    _results = [];
    for (key in _ref1) {
      value = _ref1[key];
      _results.push(this.updateTermWeight(key, value / maxScore));
    }
    return _results;
  };

  return Learner;

})();

root = typeof exports !== "undefined" && exports !== null ? exports : window;

root.Learner = Learner;
