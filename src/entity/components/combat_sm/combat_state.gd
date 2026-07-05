class_name CombatState extends State

func enter() -> void:
    provider.entered_combat.connect(_on_combat_entered)
    provider.exited_combat.connect(_on_combat_exited)
    on_enter()

func exit() -> void:
    provider.entered_combat.disconnect(_on_combat_entered)
    provider.exited_combat.disconnect(_on_combat_exited)
    on_exit()

func on_enter() -> void: pass
func on_exit() -> void: pass
func handle(_delta: float) -> void: pass

func physics_update(delta: float) -> void:
    handle(delta)

func _on_combat_entered() -> void:
    if state_machine.current_state != state_machine.get_state("InCombatState"):
        state_machine.transition_to("InCombatState")

func _on_combat_exited() -> void:
    if state_machine.current_state != state_machine.get_state("PeacefulState"):
        state_machine.transition_to("PeacefulState")
