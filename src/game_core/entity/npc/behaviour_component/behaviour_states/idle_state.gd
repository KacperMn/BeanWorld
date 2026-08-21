class_name IdleState extends BehaviourState

var wander_timer: float

func _init() -> void:
	state_name = "IdleState"

func physics_update(delta: float) -> void:
	if !awareness_component.surroundings_component.surrounding_characters.is_empty():
		check_should_interact()
	wander(delta)

func wander(delta: float) -> void:
	if arrived:
		if wander_timer <= 0:
			wander_timer = 4.0
		else:
			wander_timer -= delta
			if wander_timer <= 0.0:
				start_moving_towards(awareness_component.surroundings_component.surroundings_range.get_random_location())

func check_should_interact() -> void:
	for surrounding_character in awareness_component.surroundings_component.surrounding_characters.values():
		if !surrounding_character.relationship.interacted_recently:
			stop_walking()
			change_state.emit("InspectState")
			break