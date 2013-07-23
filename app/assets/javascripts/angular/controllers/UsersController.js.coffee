#@agendum = angular.module "agendum"

@agendum.controller 'UsersController', ($scope, $location, User) ->
	$scope.user = 
		email: ""
		password: ""
		password_confirmation: ""

	$scope.signup = ->
		new User($scope.user).$save onUserSignUp, onUserSignUpFailed

	onUserSignUp = ->
		$location.path "/tasks"

	onUserSignUpFailed = (response) ->
		$scope.errors = niceErrors(response.data.errors)

	niceErrors = (errors) ->
		["Email: " + errors.email[0],
		"Password: " + errors.password[0]]
