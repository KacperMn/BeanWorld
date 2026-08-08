class_name WanderState extends NPCActivityState

func _init() -> void:
    state_name = "WanderState"

func physics_update(delta: float) -> void:
    var detected_entities: Array = provider.entities_in_sight()
    if detected_entities.is_empty():
        provider.wander(delta)
    else:
        var reaction = provider.get_reaction(detected_entities)
        interpret_reaction(reaction)

func interpret_reaction(reaction: int) -> void:
    match reaction:
        provider.REACTION.IGNORE:
            pass ;
        provider.REACTION.APPROACH:
            change_state.emit("ApproachState")
        provider.REACTION.FIGHT:
            change_state.emit("FlightState")
        provider.REACTION.FLEE:
            change_state.emit("FlightState")