class_name StateMachine extends Node

signal state_changed(new_state: State)

var entity: Entity = get_parent() as Entity
var provider: Provider = null
var states: Array = []
var current_state: State

func _ready() -> void:
	if states.size() == 0:
		push_error("StateMachine: no states defined")
		return
	if provider == null:
		push_error("StateMachine: provider is null")
		return
	current_state = states[0]
	provider._setup(entity)
	for state in states:
		register(state)
	current_state.enter()

func get_state(state_name: String) -> State:
	for state in states:
		if state.state_name == state_name:
			return state
	return null

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

func register(state: State) -> void:
	state.entity = entity
	state.provider = provider
	state.state_machine = self