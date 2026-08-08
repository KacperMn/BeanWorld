class_name InspectState extends NPCActivityState

func _init() -> void:
    state_name = "InspectState"

func physics_update(_delta: float) -> void:
    var detected_entities = provider.entities_in_sight()
    if detected_entities.is_empty():
        change_state.emit("WanderState")
    else:
        var reaction = provider.get_reaction(detected_entities)