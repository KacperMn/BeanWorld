class_name FleeState extends BehaviourState

func _init() -> void:
	state_name = "FleeState"

func enter() -> void:
	should_be_running = true
	start_moving_towards(calculate_location_to_run_away_to())

func physics_update(_delta: float) -> void:
	if arrived:
		change_state.emit("IdleState")

func exit() -> void:
	should_be_running = false

func calculate_location_to_run_away_to() -> Vector3:
	var self_position: Vector3 = awareness_component.global_transform.origin
	var threat_position: Vector3 = interacting_character.global_transform.origin

	var away_direction: Vector3 = self_position - threat_position
	away_direction.y = 0.0

	if away_direction.is_zero_approx():
		away_direction = Vector3.RIGHT

	away_direction = away_direction.normalized()

	var flee_target: Vector3 = self_position + away_direction * 10.0
	flee_target.y = self_position.y

	return flee_target