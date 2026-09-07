class_name HealthComponent extends Node

signal health_changed(old_value: float, new_value: float)
signal died()

var stats_component: StatsComponent

func setup(stats: StatsComponent) -> void:
	assert(stats != null, "HealthComponent: missing StatsComponent")
	stats_component = stats

func hurt(amount: float) -> void:
	if amount <= 0.0:
		return
	change_health(-amount)
	if stats_component.current_health <= 0.0:
		trigger_death()

func heal(amount: float) -> void:
	if amount <= 0.0:
		return
	change_health(amount)

func revive() -> void:
	stats_component.set_current_health(stats_component.max_health)

func change_health(amount: float) -> void:
	var old_health: float = stats_component.current_health
	stats_component.set_current_health(clampf(stats_component.current_health + amount, 0.0, stats_component.max_health))
	health_changed.emit(old_health, stats_component.current_health)

func trigger_death() -> void:
	died.emit()
