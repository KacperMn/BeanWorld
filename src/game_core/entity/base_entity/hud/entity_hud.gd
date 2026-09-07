class_name EntityHUD extends Node3D

@onready var healthbar: ProgressBar = $SubViewport/HealthBar

func setup(max_health: float, shape: Shape3D) -> void:
	healthbar.max_value = max_health
	healthbar.value = max_health
	position.y += shape.height + 1.0

func _on_health_changed(_old_value: float, new_value: float) -> void:
	healthbar.value = new_value