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
            pass;
        provider.REACTION.APPROACH:
            state_machine.transition_to("ApproachState")
        provider.REACTION.FIGHT:
            state_machine.transition_to("FightState")
        provider.REACTION.FLEE:
            state_machine.transition_to("FleeState")