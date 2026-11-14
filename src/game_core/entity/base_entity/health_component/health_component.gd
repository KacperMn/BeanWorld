class_name HealthComponent extends Node

signal health_changed(new_value: float)
signal died()

var stats_component: StatsComponent

func setup(stats: StatsComponent) -> void:
	assert(stats != null, "HealthComponent: missing StatsComponent")
	stats_component = stats

func hurt(amount: float) -> void:
	if amount <= 0.0:
		return
	change_health(-amount)
	if stats_component.health_stat.current_value <= 0.0:
		trigger_death()

func heal(amount: float) -> void:
	if amount <= 0.0:
		return
	change_health(amount)

func revive() -> void:
	stats_component.health_stat.set_value_to_max()

func change_health(amount: float) -> void:
	stats_component.health_stat.change_value(amount)
	health_changed.emit(stats_component.health_stat.current_value)

func trigger_death() -> void:
	died.emit()
