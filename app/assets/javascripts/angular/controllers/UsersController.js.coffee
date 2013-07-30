#@agendum = angular.module "agendum"

@agendum.controller 'UsersController', ['$scope', '$location', '$cookies', 'User', ($scope, $location, $cookies, User) ->
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
		errorArray = []
		errorArray.push("Email: " + errors.email[0]) if errors.email != undefined
		errorArray.push("Password: " + errors.password[0]) if errors.password != undefined
		errorArray.push("Passwords must match") if errors.password_confirmation != undefined
		errorArray
]