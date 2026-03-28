class_name PlayerMovementProvider extends MovementProvider

var camera_arm: Node3D

func get_direction(_entity: Entity) -> Vector3:
    if not enabled:
        return Vector3.ZERO
    var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_back")
    if input_dir == Vector2.ZERO:
        return Vector3.ZERO
    var direction := camera_arm.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)
    direction.y = 0.0
    return direction.normalized()

func wants_jump() -> bool:
    if not enabled:
        return false
    return Input.is_action_just_pressed("jump")

func wants_jump_held() -> bool:
    if not enabled:
        return false
    return Input.is_action_pressed("jump")

func wants_sprint() -> bool:
    if not enabled:
        return false
    return Input.is_action_pressed("sprint")