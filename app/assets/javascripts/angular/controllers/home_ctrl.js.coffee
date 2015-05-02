myGreenSpace.controller 'HomeCtrl', [
  '$scope', 'Token'
  ($scope, Token) ->

    $scope.newToken = {}

    $scope.create = ->
      $scope.newToken['grant_type'] = 'password'
      Token.save($scope.newToken).$promise.then ((value) ->
        $scope.responseStatus = 'OK'
        $scope.response = value
        $scope.newToken = {}
        return
      ), (error) ->
        $scope.responseStatus = 'Error'
        $scope.response = error.data
        return

    $scope.signInViaFacebook = ->
      $scope.newToken['grant_type'] = 'assertion'
      $scope.newToken['assertion_type'] = 'facebook'
      Token.save($scope.newToken).$promise.then ((value) ->
        $scope.responseStatus = 'OK'
        $scope.response = value
        $scope.newToken = {}
        return
      ), (error) ->
        $scope.responseStatus = 'Error'
        $scope.response = error.data
        return

]


