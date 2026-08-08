class_name SprintState extends MovementState

@export var sprint_multiplier: float = 1.8

func _init() -> void:
    state_name = "SprintState"

func handle(delta: float) -> void:
    if is_on_floor and provider.wants_jump():
        change_state.emit("JumpState")
        return
    if provider.get_direction() == Vector3.ZERO:
        change_state.emit("StandState")
        return
    if not provider.wants_sprint():
        change_state.emit("WalkState")
        return
    calculate_movement(delta, speed * sprint_multiplier)
    rotate_entity_to_velocity(delta)