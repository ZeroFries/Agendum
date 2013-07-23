@agendum = angular.module "agendum", ['ngResource', 'ngCookies']	

@agendum.config ($routeProvider, $locationProvider) ->
	$routeProvider
	.when('/', templateUrl: "/assets/home.html")
	.when('/login', templateUrl: "/assets/login.html", controller: 'SessionsController')
	.when('/signup', templateUrl: "/assets/signup.html", controller: 'UsersController')
	.otherwise(template: "Page not found.")

@agendum.run ['$window', '$templateCache', ($window, $templateCache) ->
  # Load the templates into the angular template cache when angular 
  # starts up. This means angular doesn't need to download each template from 
  # the server when a page is requested.
  for name, templateFunction of $window.JST
    $templateCache.put(name, templateFunction)
]

# define user factory/ngResource
@agendum.factory "User", ($resource) ->
	$resource '/api/users/:id', {id: '@id'}

@agendum.factory "Session", ($resource) ->
	$resource '/api/session'