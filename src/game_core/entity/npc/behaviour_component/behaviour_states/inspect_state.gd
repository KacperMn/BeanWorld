class_name InspectState extends BehaviourState

var inspect_timer: float = 0.0
var reaction_state: String

func _init() -> void:
	state_name = "InspectState"

func enter() -> void:
	inspect_timer = 2.0

func physics_update(delta: float) -> void:
	if inspect_timer >= 0.0:
		inspect_timer -= delta
	else:
		change_state.emit(reaction_state)
	if check_if_should_check_out():
		process_initial_reaction()

func process_initial_reaction() -> void:
	if awareness_component.surroundings_component.surrounding_characters.size() == 1:
		var only: SurroundingCharacter = awareness_component.surroundings_component.surrounding_characters.values()[0]
		if !only.relationship.interacted_recently:
			process_single_reaction(only)
	else:
		process_group_reaction()

func check_if_should_check_out() -> bool:
	var all_checked_out: bool = true
	for surrounding_character in awareness_component.surroundings_component.surrounding_characters.values():
		if !surrounding_character.checked_out:
			all_checked_out = false
			break
	return !all_checked_out

func process_single_reaction(surrounding_character: SurroundingCharacter) -> void:
	interacting_character = surrounding_character.character
	if surrounding_character.relationship.fondness >= 50.0:
		reaction_state = "InteractionState"
	elif surrounding_character.relationship.fear >= 50.0:
		reaction_state = "FleeState"
	else:
		surrounding_character.relationship.interacted_recently = true
		surrounding_character.checked_out = true
		reaction_state = "IdleState"

func process_group_reaction() -> void:
	for surrounding_character in awareness_component.surroundings_component.surrounding_characters.values():
		surrounding_character.relationship.interacted_recently = true
		surrounding_character.checked_out = true
	reaction_state = "IdleState"