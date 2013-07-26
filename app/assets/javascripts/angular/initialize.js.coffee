@agendum = angular.module "agendum", ['ngResource', 'ngCookies']	

# things left to do: fix signup errors, try rendering home as a bunch of partials
# filters to check if user is logged in or not
@agendum.config ($routeProvider, $locationProvider) ->
	$routeProvider
	.when('/', templateUrl: "/assets/home.html", controller: 'StaticController')
	.when('/login', templateUrl: "/assets/login.html", controller: 'SessionsController')
	.when('/logout', templateUrl: "/assets/home.html", controller: 'SessionsController')
	.when('/signup', templateUrl: "/assets/signup.html", controller: 'UsersController')
	.when('/tasks', templateUrl: "/assets/tasks.html", controller: 'TasksController')
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

@agendum.factory "Task", ($resource) ->
	$resource "/api/tasks/:id", {id: '@id'}

@agendum.factory "Tasks", ($resource) ->
	$resource "/api/tasks"

@agendum.factory "SentTask", ($resource) ->
	$resource "/api/sent_tasks/:id", {id: '@id'}
	#, {'save': {method:'Post', parameters: ('emails', 'sender_email', 'description') isArray:true}}

@agendum.factory "SentTasks", ($resource) ->
	$resource "/api/sent_tasks"

@agendum.factory "Notification", ($resource) ->
	$resource "/api/notifications/:id", {id: '@id'}