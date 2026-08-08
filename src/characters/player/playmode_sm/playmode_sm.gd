class_name PlayModeSM extends StateMachine

var is_in_combat: bool

func setup() -> void:
	add_states([ExplorationState.new(), BuildingState.new(), FightingState.new()])
	current_state = states[states.find(ExplorationState)]
	super()

func _on_combat_entered() -> void:
	is_in_combat = true
	set_current_state_combat_status()

func _on_combat_exited() -> void:
	is_in_combat = false
	set_current_state_combat_status()

func handle_state_entered(_state: String) -> void:
	set_current_state_combat_status()

func set_current_state_combat_status() -> void:
	current_state.is_in_combat = is_in_combat
