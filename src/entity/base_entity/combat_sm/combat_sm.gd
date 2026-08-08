class_name CombatSM extends StateMachine

signal entered_combat()
signal exited_combat()

var is_dead: bool = false
const COMBAT_TIMER_NAME = "CombatTimer"

func setup() -> void:
	add_states([PeacefulState.new(), InCombatState.new()])
	for state in states:
		if state is PeacefulState:
			current_state = state
	super()

func enter_combat() -> void:
	if is_dead:
		return
	if current_state is PeacefulState:
		setup_combat_timer()
		transition_to("InCombatState")
		entered_combat.emit()
	else:
		extend_combat_timer()

func exit_combat() -> void:
	var combat_timer = get_node_or_null(COMBAT_TIMER_NAME)
	if combat_timer:
		combat_timer.queue_free()
		transition_to("PeacefulState")
		exited_combat.emit()

func _on_dead_entity() -> void:
	is_dead = true

func _on_revived_entity() -> void:
	is_dead = false

func setup_combat_timer() -> void:
	var combat_timer = Timer.new()
	combat_timer.name = COMBAT_TIMER_NAME
	combat_timer.wait_time = 5.0
	combat_timer.one_shot = true
	combat_timer.timeout.connect(exit_combat)
	add_child(combat_timer)
	combat_timer.start()

func extend_combat_timer() -> void:
	var combat_timer = get_node_or_null(COMBAT_TIMER_NAME)
	if combat_timer:
		combat_timer.stop()
		combat_timer.wait_time = 5.0
		combat_timer.start()
	else:
		setup_combat_timer()