@agendum.controller 'TasksController', ($scope, $location, $cookies, Tasks, Task) ->
	$scope.task =
		email: $cookies.currentUserEmail
		description: ""

	Tasks.query({email: $cookies.currentUserEmail}, (info) ->
		# must use a call back since its an asynchronous call
		$scope.tasks = info
		# trying hack
		#$scope.descriptions = (t.description for t in $scope.tasks)
		#console.log $scope.descriptions
	)

	$scope.addTask = ->
		new Task($scope.task).$save onTaskAdd
		

	onTaskAdd = ->
		$scope.task.description = ""
		Tasks.query({email: $cookies.currentUserEmail}, (info) ->
			$scope.tasks = info
		console.log $scope.tasks[0]
		)