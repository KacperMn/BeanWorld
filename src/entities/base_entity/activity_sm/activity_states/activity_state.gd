class_name ActivityState extends State

func update(_delta: float) -> void:
    if entity.is_in_combat and state_name != "CombatState":
        state_machine.transition_to("CombatState")
    elif !entity.is_in_combat and state_name == "CombatState":
        state_machine.transition_to("ExplorationState")