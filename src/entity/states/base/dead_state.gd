class_name DeadState extends State


func _init() -> void:
    state_name = "DeadState"

func enter() -> void:
    on_enter()

func on_enter() -> void:
    pass  # override: ragdoll, loot drop, reload scene, etc.