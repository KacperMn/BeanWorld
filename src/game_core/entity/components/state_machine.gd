class_name StateMachine extends Node

signal state_changed(new_state: State)

@export var provider: Provider
var states: Array = []
var current_state: State

func setup_sm() -> void:
	if states.size() == 0:
		push_error("StateMachine: no states defined")
		return
	if not current_state:
		current_state = states[0]
	current_state.enter()
	
func get_state(state_name: String) -> State:
	for state in states:
		if state.state_name == state_name:
			return state
	return null

func transition_to(state_name: String) -> void:
	if current_state.state_name == state_name:
		return
	var new_state: State = get_state(state_name)
	if new_state:
		current_state.exit()
		current_state = new_state
		current_state.enter()
		state_changed.emit(current_state)
	else:
		push_error("StateMachine: state not: " + state_name + " trying to exit " + current_state.state_name)

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func add_state(state: State) -> void:
	state.change_state.connect(self.transition_to)
	state.entered_state.connect(self.handle_state_entered)
	state.exited_state.connect(self.handle_state_exited)
	state.provider = provider
	states.append(state)

func handle_state_entered(state: String) -> void:
	pass

func handle_state_exited(state: String) -> void:
	pass

func add_states(state_array: Array[State]) -> void:
	for state in state_array:
		add_state(state)

func _get_configuration_warnings() -> PackedStringArray:
	var warnings: PackedStringArray = []
	if not provider:
		warnings.append("The State Machine is missing a provider")
	return warnings
