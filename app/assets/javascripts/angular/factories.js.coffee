myGreenSpace.factory 'User', ['$resource', ($resource) ->
  $resource('/v1/users/:id', {id: '@id'}, {update: {method: 'PUT'}})
]

myGreenSpace.factory 'Token', ['$resource', ($resource) ->
  $resource('/oauth/token')
]
