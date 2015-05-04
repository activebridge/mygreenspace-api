myGreenSpace.controller 'LinksCtrl', [
  '$scope', '$routeParams', '$route', '$location'
  ($scope, $routeParams, $route, $location) ->

    $scope.showDemoLinks = $location.url().indexOf('test-api') > -1
]
