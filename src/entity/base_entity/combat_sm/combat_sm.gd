class_name CombatSM extends StateMachine

var is_dead: bool

func setup() -> void:
	add_states([PeacefulState.new(), InCombatState.new()])
	for state in states:
		if state is PeacefulState:
			current_state = state
	super()

func set_combat_data(_is_dead: bool) -> void:
	is_dead = _is_dead

func enter_combat() -> void:
	if is_dead:
		return
	
	const COMBAT_TIMER_NAME = "CombatTimer"
	var combat_timer = get_node_or_null(COMBAT_TIMER_NAME)
	
	if current_state is PeacefulState:
		combat_timer = Timer.new()
		combat_timer.name = COMBAT_TIMER_NAME
		combat_timer.wait_time = 5.0
		combat_timer.one_shot = true
		combat_timer.connect("timeout", Callable(self, "exit_combat"))
		add_child(combat_timer)
		combat_timer.start()
		transition_to("InCombatState")
	else:
		if combat_timer:
			combat_timer.stop()
			combat_timer.wait_time = 5.0
			combat_timer.start()

func exit_combat() -> void:
	var combat_timer = get_node_or_null("CombatTimer")
	if combat_timer:
		combat_timer.queue_free()
		transition_to("PeacefulState")