@agendum.controller 'UsersController', ($scope, $location, Session) ->
	$scope.user = 
		email: ""
		password: ""

	$scope.signup = ->
		new Session($scope.user).$save onUserLogin, onUserLoginFailed

	onUserLogin = ->
		$location.path "/tasks"

	onUserLoginFailed = (response) ->
		$scope.errors = niceErrors(response.data.errors)

	niceErrors = (errors) ->
		["Email: " + errors.email[0],
		"Password: " + errors.password[0]]