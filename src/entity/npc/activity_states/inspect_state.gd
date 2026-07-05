class_name InspectState extends NPCActivityState

func _init() -> void:
    state_name = "InspectState"

func physics_update(_delta: float) -> void:
    if not provider.entities_in_sight():
        state_machine.transition_to("WanderState")
    else:
        # Implement inspection behavior here
        # Stop and look in the direction of entity / avg direction of entities
        # Logic for assessing approach/fight/flight
        # Transition to appropriate state based on assessment
        pass