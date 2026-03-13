class_name PlayerDeadState extends DeadState

func on_enter() -> void:
    entity.set_physics_process(false)
    await entity.get_tree().create_timer(2.0).timeout
    entity.get_tree().reload_current_scene()