myGreenSpace.controller 'HomeCtrl', [
  '$scope', 'User'
  ($scope, User) ->

    $scope.newUser = {}

    $scope.create = ->
      $scope.newUser['sign_up_type'] = 'email'
      User.save(user: $scope.newUser).$promise.then ((value) ->
        $scope.responseStatus = 'OK'
        $scope.userInfo = value
        $scope.newUser = {}
        return
      ), (error) ->
        $scope.responseStatus = 'Error'
        $scope.userInfo = error.data
        return


]


