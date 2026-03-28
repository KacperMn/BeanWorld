class_name StateMachine extends Node

signal state_changed(new_state: State)

var states: Dictionary[String, State] = {}
var current_state: State

func start(initial_state: State) -> void:
	current_state = initial_state
	current_state.enter()

func get_state(state_name: String) -> State:
	return states.get(state_name, null)

func transition_to(state_name: String) -> void:
	var new_state: State = get_state(state_name)
	if new_state:
		if new_state == current_state:
			return
		current_state.exit()
		current_state = new_state
		current_state.enter()
		state_changed.emit(current_state)
		print("StateMachine: transition_to called with state_name: %s" % state_name)
	else:
		push_error("StateMachine: state not found: %s" % state_name)

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)
