@agendum.controller 'TasksController', ($scope, $location, $cookies, Tasks, Task, SentTask, SentTasks, User) ->
	$scope.task =
		email: $cookies.currentUserEmail
		description: ""

	$scope.send_task =
		sender_email: $cookies.currentUserEmail
		emails: ""
		description: ""

	Tasks.query({email: $cookies.currentUserEmail}, (info) ->
		# must use a call back since query is an asynchronous function
		$scope.tasks = info
	)

	SentTasks.query({email: $cookies.currentUserEmail}, (info) ->
		$scope.showSentTaskPane = true
		$scope.sent_tasks = info
		$scope.senders = (User.get(id: t.sender_id) for t in $scope.sent_tasks)
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

	$scope.toggleSentTaskPane = ->
		$scope.showSentTaskPane = !$scope.showSentTaskPane
		$scope.notification = ""
		$scope.errors = []

	$scope.sendTask = ->
		new SentTask($scope.send_task).$save onTaskSend, onTaskSendFail

	onTaskSend = ->
		$scope.send_task.description = ""
		$scope.send_task.emails = ""
		$scope.errors = []
		$scope.notification = "Task sent"

	onTaskSendFail = (info) ->
		console.log info
		$scope.errors = info
		$scope.send_task.emails = ""
		$scope.send_task.emails += (email for email in $scope.errors.data)

	$scope.transferTask = (id) ->
		# create new task
		SentTask.get(id: id, (t) ->
			console.log t
			$scope.task.description = t.description
			new Task($scope.task).$save onTaskAdd
		)
		# delete sent task
		SentTask.delete(id: id, ->
			# reload sent tasks
			SentTasks.query({email: $cookies.currentUserEmail}, (info) ->
				$scope.sent_tasks = info
				$scope.senders = (User.get(id: t.sender_id) for t in $scope.sent_tasks)
			)
		)
		# send notification

	$scope.dismissTask = (id) ->
		SentTask.delete(id: id, ->
			# reload sent tasks
			SentTasks.query({email: $cookies.currentUserEmail}, (info) ->
				$scope.sent_tasks = info
				$scope.senders = (User.get(id: t.sender_id) for t in $scope.sent_tasks)
			)
		)
		# send notification

# refacotr: one method to query and destroy sent task?