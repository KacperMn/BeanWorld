class_name Player extends Entity

var idle_state: PlayerIdleState
var walk_state: PlayerWalkState
var jump_state: PlayerJumpState
var hurt_state: PlayerHurtState
var dead_state: PlayerDeadState

func _ready() -> void:
	super ()
	idle_state = PlayerIdleState.new()
	walk_state = PlayerWalkState.new()
	jump_state = PlayerJumpState.new()
	hurt_state = PlayerHurtState.new()
	dead_state = PlayerDeadState.new()

	for state in [idle_state, walk_state, hurt_state, dead_state]:
		state.entity = self

	state_machine.start(idle_state, self )
func _on_health_changed(old_val: float, new_val: float) -> void:
	if new_val < old_val and not is_dead:
		state_machine.transition_to(hurt_state)

func _on_died() -> void:
	state_machine.transition_to(dead_state)
