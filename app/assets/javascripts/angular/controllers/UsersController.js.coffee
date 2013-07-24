#@agendum = angular.module "agendum"

@agendum.controller 'UsersController', ($scope, $location, $cookies, User) ->
	# look into filters to see if i can just redirect with one of those
	if $cookies.currentUserEmail != undefined
		$location.path "/tasks"
	$scope.user = 
		email: ""
		password: ""
		password_confirmation: ""

	$scope.signup = ->
		new User($scope.user).$save onUserSignUp, onUserSignUpFailed

	onUserSignUp = ->
		$cookies.currentUserEmail = $scope.user.email
		$location.path "/tasks"

	onUserSignUpFailed = (response) ->
		$scope.errors = niceErrors(response.data.errors)

	niceErrors = (errors) ->
		["Password: " + errors.password[0],
		"Email: " + errors.email[0]]
