class_name CombatProvider extends Provider

signal entered_combat()
signal exited_combat()

func enter_combat() -> void:
	if entity.is_dead:
		return
	
	const COMBAT_TIMER_NAME = "CombatTimer"
	var combat_timer = entity.get_node_or_null(COMBAT_TIMER_NAME)
	
	if !entity.is_in_combat:
		entered_combat.emit()
		combat_timer = Timer.new()
		combat_timer.name = COMBAT_TIMER_NAME
		combat_timer.wait_time = 5.0
		combat_timer.one_shot = true
		combat_timer.connect("timeout", Callable(self, "exit_combat"))
		entity.add_child(combat_timer)
		combat_timer.start()
	else:
		if combat_timer:
			combat_timer.stop()
			combat_timer.wait_time = 5.0
			combat_timer.start()

func exit_combat() -> void:
	exited_combat.emit()
	var combat_timer = entity.get_node_or_null("CombatTimer")
	if combat_timer:
		combat_timer.queue_free()
