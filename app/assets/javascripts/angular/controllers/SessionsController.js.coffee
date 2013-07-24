@agendum.controller 'SessionsController', ($scope, $location, $cookies, Session) ->
	if $location.path() == "/logout"
		console.log "yo"
		delete $cookies.currentUserEmail
		$location.path "/"

	$scope.user = 
		email: ""
		password: ""

	$scope.login = ->
		new Session($scope.user).$save onUserLogin, onUserLoginFailed

	onUserLogin = ->
		$cookies.currentUserEmail = $scope.user.email
		$location.path "/tasks"

	onUserLoginFailed = (response) ->
		$scope.errors = ["Wrong login details"]