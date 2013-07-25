@agendum.controller 'TasksController', ($scope, $location, $cookies, Tasks, Task) ->
	$scope.task =
		email: $cookies.currentUserEmail
		description: ""

	Tasks.query({email: $cookies.currentUserEmail}, (info) ->
		# must use a call back since query is an asynchronous function
		$scope.tasks = info
	)

	$scope.addTask = ->
		new Task($scope.task).$save onTaskAdd
		

	onTaskAdd = (t) ->
		$scope.task.description = ""
		$scope.tasks.push t

	$scope.removeTask = (id) ->
		Task.delete(id: id, ->
			# reload Tasks once deletion is complete; simply popping the task off was messing with the ID's
			Tasks.query({email: $cookies.currentUserEmail}, (info) ->
				$scope.tasks = info
			)
		)