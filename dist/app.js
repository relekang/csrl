var app;

app = angular.module("csrl", [], function() {});

app.controller("demoController", [
  "$scope", function($scope) {
    $scope.safeApply = function(fn) {
      var phase;
      phase = this.$root.$$phase;
      if (phase === "$apply" || phase === "$digest") {
        if (fn && (typeof fn === "function")) {
          return fn();
        }
      } else {
        return this.$apply(fn);
      }
    };
    $scope.learner = new Learner;
    $.getJSON('documents.json', function(data) {
      $scope.results = data;
      $scope.learner.rank($scope.results);
      return $scope.safeApply();
    });
    $scope.clickResult = function(item) {
      $scope.learner.reportClick(item);
      $scope.learner.rank($scope.results);
      return $scope.safeApply();
    };
    return $scope.reset = function() {
      Learner.reset();
      $scope.learner.rank($scope.results);
      return $scope.safeApply();
    };
  }
]);
