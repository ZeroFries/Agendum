@agendum.controller 'SessionsController', ($scope, $location, $cookies, Session) ->
	$scope.user = 
		email: ""
		password: ""

	$scope.login = ->
		console.log "hi"
		new Session($scope.user).$save onUserLogin, onUserLoginFailed

	onUserLogin = ->
		$cookies.currentUserEmail = $scope.user.email
		$location.path "/tasks"

	onUserLoginFailed = (response) ->
		$scope.errors = ["Wrong login details"]