class_name SprintState extends MovementState

@export var sprint_multiplier: float = 1.8

func _init() -> void:
    state_name = "SprintState"

func handle(delta: float) -> void:
    if entity.is_on_floor() and provider.wants_jump():
        movement_sm.transition_to("DashState")
        return
    if provider.get_direction(entity) == Vector3.ZERO:
        movement_sm.transition_to("IdleState")
        return
    if not provider.wants_sprint():
        movement_sm.transition_to("WalkState")
        return
    apply_movement(delta, entity.speed * sprint_multiplier)
    rotate_entity_to_velocity(delta)