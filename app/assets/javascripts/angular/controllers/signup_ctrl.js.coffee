myGreenSpace.controller 'SignupCtrl', [
  '$scope', 'User', 'Token'
  ($scope, User, Token) ->

    $scope.newUser = {}

    $scope.createByEmail = ->
      $scope.newUser['sign_up_type'] = 'email'
      User.save(user: $scope.newUser).$promise.then ((value) ->
        $scope.responseStatus = 'OK'
        $scope.response = value
        $scope.newUser = {}
        return
      ), (error) ->
        $scope.responseStatus = 'Error'
        $scope.response = error.data
        return


    $scope.createViaFacebook = ->
      $scope.newUser['grant_type'] = 'assertion'
      $scope.newUser['assertion_type'] = 'facebook'
      Token.save($scope.newUser).$promise.then ((value) ->
        $scope.responseStatus = 'OK'
        $scope.response = value
        $scope.newUser = {}
        return
      ), (error) ->
        $scope.responseStatus = 'Error'
        $scope.response = error.data
        return


]


