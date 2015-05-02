myGreenSpace.controller 'TokenCtrl', [
  '$scope', 'User', 'Token'
  ($scope, User, Token) ->

    $scope.fetch = ->
      $scope.newToken['id'] = '0'
      User.get($scope.newToken).$promise.then ((value) ->
        $scope.responseStatus = 'OK'
        $scope.response = value
        return
      ), (error) ->
        $scope.responseStatus = 'Error'
        $scope.response = error.data
        return


]


