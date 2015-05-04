etcHtml5Config = ($locationProvider) ->
  $locationProvider.html5Mode true

etcHtml5Config.$inject = ['$locationProvider']
myGreenSpace.config etcHtml5Config
