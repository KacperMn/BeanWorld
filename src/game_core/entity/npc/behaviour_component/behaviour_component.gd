class_name BehaviourComponent extends StateMachine

@export var behaviour_states: Array[BehaviourState] = [IdleState.new()]

var stats_component: StatsComponent
var status_component: StatusComponent
var awareness_component: AwarenessComponent

signal new_target_location(target_location: Vector3)

var interacting_character: Character

var target_location: Vector3:
	set(value):
		target_location = value
		new_target_location.emit(target_location)

func setup(stats: StatsComponent, status: StatusComponent, awareness: AwarenessComponent) -> void:
	assert(stats != null)
	assert(status != null)
	assert(awareness != null)
	stats_component = stats
	status_component = status
	awareness_component = awareness
	setup_sm()

func setup_sm() -> void:
	var typed_states: Array[State] = []
	typed_states.assign(behaviour_states)
	add_states(typed_states)
	current_state = get_state("IdleState")
	for state in states:
		state.stats_component = stats_component
		state.status_component = status_component
		state.awareness_component = awareness_component
		state.new_target_location.connect(_on_state_new_target_location)
		state.new_interacting_character.connect(set_interacting_character)
		super()

func handle_state_entered(_state: String) -> void:
	if interacting_character:
		current_state.interacting_character = interacting_character

func _on_state_new_target_location(location: Vector3) -> void:
	target_location = location

func set_interacting_character(character: Character) -> void:
	interacting_character = character

func arrived() -> void:
	current_state.arrived = true
