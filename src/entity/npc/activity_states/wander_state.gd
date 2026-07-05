class_name WanderState extends NPCActivityState

func _init() -> void:
    state_name = "WanderState"

func physics_update(_delta: float) -> void:
    if not provider.entities_in_sight():
        provider.wander(_delta)
    else:
        state_machine.transition_to("InspectState")