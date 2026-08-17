class_name MovementSM extends StateMachine

var stats_component: StatsComponent
var status_component: StatusComponent
var character_body: CharacterBody3D

func setup(stats: StatsComponent, status: StatusComponent, character: CharacterBody3D) -> void:
	assert(stats != null)
	assert(status != null)
	assert(character != null)
	stats_component = stats
	status_component = status
	character_body = character
	provider.enabled = status.is_alive
	provider.entity = character_body
	setup_sm()

func setup_sm() -> void:
	add_states([StandState.new(), FallState.new(), WalkState.new(), JumpState.new(), SprintState.new(), DashState.new()])
	current_state = get_state("StandState")
	for state in states:
		state.stats_component = stats_component
		state.character_body = character_body
	super()

func _physics_process(_delta: float) -> void:
	super(_delta)
	provider.enabled = status_component.is_alive
	character_body.move_and_slide()
