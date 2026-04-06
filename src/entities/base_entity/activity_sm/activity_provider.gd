class_name ActivityProvider extends Provider

func get_is_in_combat(state_name: String) -> void:
    if entity.is_in_combat and state_name != "CombatState":
        entity.activity_sm.transition_to("CombatState")
    elif !entity.is_in_combat and state_name == "CombatState":
        entity.activity_sm.transition_to("ExplorationState")

func get_wants_to_build(state_name: String) -> void:
    pass