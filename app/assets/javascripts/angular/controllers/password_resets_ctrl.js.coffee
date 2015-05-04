myGreenSpace.controller 'PasswordResetsCtrl', [
  '$scope', 'PasswordReset', '$routeParams', '$location'
  ($scope, PasswordReset, $routeParams, $location) ->

    $scope.submit = ->
      PasswordReset.save(email: $scope.email).$promise.then ((value) ->
        $scope.email = null
        $scope.response = value
        return
      ), (error) ->
        $scope.response =
          status: 'error'
          message: error.statusText
        return

    $scope.user = {password: '', password_confirmation: ''}
    $scope.response = {}
    $scope.update = ->
      if $scope.user.password == ''
        $scope.response.message = "Password can't be blank"
        $scope.response.status = "error"
      else
        PasswordReset.update(user: $scope.user, id: $routeParams.token).$promise.then ((data) ->
          if data.status == 'ok'
            $location.path('/')
            $scope.response = {message: 'Password was successfully changed'}
          else
            $scope.response = data
          return
        ), (error) ->
          $scope.response =
            status: 'error'
            message: error.statusText
          return

]


