class_name EntityHUD extends Node3D

var stats_component: StatsComponent

@onready var healthbar: ProgressBar = $SubViewport/HealthBar

func setup(stats: StatsComponent, shape: Shape3D) -> void:
	assert(stats != null, "HUD: missing StatsComponent")
	stats_component = stats
	healthbar.max_value = stats.max_health
	healthbar.value = stats.max_health
	position.y += shape.height + 1.0

func _on_health_changed(_old_value: float, new_value: float) -> void:
	healthbar.value = new_value