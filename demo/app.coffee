app = angular.module("csrl", [], ->)
app.controller "demoController", ["$scope", ($scope) ->
  $scope.safeApply = (fn) ->
    phase = @$root.$$phase
    if phase is "$apply" or phase is "$digest"
      fn()  if fn and (typeof (fn) is "function")
    else
      @$apply fn

  $scope.learner = new Learner
  $.getJSON 'documents.json', (data) ->
    $scope.results = data
    $scope.learner.rank $scope.results
    $scope.safeApply()

  $scope.clickResult = (item) ->
    $scope.learner.reportClick item
    $scope.learner.rank $scope.results
    $scope.safeApply()

  $scope.reset = ->
    Learner.reset()
    $scope.learner.rank $scope.results
    $scope.safeApply()
]