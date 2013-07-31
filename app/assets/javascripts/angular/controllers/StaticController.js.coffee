@agendum.controller 'StaticController', ['$scope', '$location', '$cookies', 'User', ($scope, $location, $cookies, User) ->
	# look into filters to see if i can just redirect with one of those
	console.log "yo"
	if $cookies.currentUserEmail != undefined
		console.log $cookies.currentUserEmail
		$location.path "/tasks"
]