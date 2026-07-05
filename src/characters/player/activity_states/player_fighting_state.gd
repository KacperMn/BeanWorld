class_name PlayerFightingState extends FightingState

func physics_update(delta: float) -> void:
    if !provider.get_combat_state():
        state_machine.transition_to("ExplorationState")