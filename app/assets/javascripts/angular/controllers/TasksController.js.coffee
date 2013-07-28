@agendum.controller 'TasksController', ($scope, $location, $cookies, Tasks, Task, SentTask, SentTasks, User, Notification) ->
	# redirect non-logged in users
	if $cookies.currentUserEmail == undefined
		$location.path "/"

	# --- MODELS ---

	$scope.user =
		email: $cookies.currentUserEmail

	$scope.task =
		email: $scope.user.email
		description: ""

	$scope.send_task =
		sender_email: $scope.user.email
		emails: ""
		description: ""

	Tasks.query({email: $scope.user.email}, (info) ->
		# must use a call back since query is an asynchronous function
		$scope.tasks = info
	)

	SentTasks.query({email: $scope.user.email}, (info) ->
		$scope.showSentTaskPane = true
		$scope.sent_tasks = info
		$scope.senders = (User.get(id: t.sender_id) for t in $scope.sent_tasks)
	)

	Tasks.query({email: $scope.user.email}, (info) ->
		# must use a call back since query is an asynchronous function
		$scope.tasks = info
	)

	# --- HELPERS ---

	loadSentTasks = ->
		SentTasks.query({email: $scope.user.email}, (info) ->
			$scope.sent_tasks = info
			$scope.senders = (User.get(id: t.sender_id) for t in $scope.sent_tasks)
		)

	loadNotifications = ->
		Notification.query({email: $scope.user.email}, (info) ->
			$scope.notifications = info
		)


	# --- ACTIONS ---

	loadNotifications()

	$scope.addTask = ->
		new Task($scope.task).$save onTaskAdd
		loadNotifications()
		loadSentTasks()

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
		$scope.notice = ""
		$scope.errors = []
		loadSentTasks() if $scope.showSentTaskPane
		loadNotifications()
		loadSentTasks()

	$scope.sendTask = ->
		new SentTask($scope.send_task).$save onTaskSend, onTaskSendFail

	onTaskSend = ->
		$scope.send_task.description = ""
		$scope.send_task.emails = ""
		$scope.errors = []
		$scope.showSentTaskPane = !$scope.showSentTaskPane
		$scope.notice = "Task sent"
		loadNotifications()
		loadSentTasks()

	onTaskSendFail = (info) ->
		$scope.errors = info
		$scope.send_task.emails = ""
		$scope.send_task.emails += (email for email in $scope.errors.data)

	$scope.transferTask = (id) ->
		# note: methods must cascade down due to relying on asynch call to complete before proceeding to next step
		# send notification
		new Notification(task_id: id, verb: "accepted").$save ->
			# create new task
			SentTask.get(id: id, (t) ->
				$scope.task.description = t.description
				new Task($scope.task).$save onTaskAdd
				# delete sent task
				SentTask.delete(id: id, ->
					# reload sent tasks
					loadSentTasks()
					loadNotifications()
				)
			)

	$scope.dismissTask = (id) ->
		# send notification
		new Notification(task_id: id, verb: "dismissed").$save ->
			SentTask.delete(id: id, ->
				# reload sent tasks
				loadSentTasks()
				loadNotifications()
			)


	$scope.clearNotifications = ->
		Notification.delete({email: $scope.user.email, id: 1}, ->
			$scope.notifications = []
		)
