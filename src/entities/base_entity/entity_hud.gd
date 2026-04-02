class_name EntityHUD extends Node3D

@onready var healthbar: ProgressBar = $SubViewport/HealthBar
@onready var entity: Entity = get_parent() as Entity

func _ready() -> void:
	position.y = entity.position.y + entity.entity_height + 1.0
	call_deferred("setup_healthbar")

func setup_healthbar() -> void:
	if entity is Player:
		healthbar.visible = false
	var health_provider: HealthProvider = entity.vitality_sm.health_provider
	healthbar.max_value = entity.max_health
	healthbar.value = health_provider.health
	health_provider.health_changed.connect(_on_health_changed)

func _on_health_changed(_old_value: float, new_value: float) -> void:
	healthbar.value = new_value
