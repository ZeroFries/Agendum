@agendum.controller 'TasksController', ($scope, $location, $cookies, Tasks, Task) ->
	$scope.task =
		email: $cookies.currentUserEmail
		description: ""

	Tasks.query({email: $cookies.currentUserEmail}, (info) ->
		# must use a call back since its an asynchronous call
		$scope.tasks = info
		console.log $scope.tasks[0]
	)

	$scope.addTask = ->
		new Task($scope.task).$save onTaskAdd
		Tasks.query({email: $cookies.currentUserEmail}, (info) ->
			$scope.tasks = info
			console.log $scope.tasks[0].description
		)

	onTaskAdd = ->
		$scope.task.description = ""