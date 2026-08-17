class_name HealthComponent extends Node

signal health_changed(old_value: float, new_value: float)
signal revived()
signal died()

var stats_component: StatsComponent
var status_component: StatusComponent

func setup(stats: StatsComponent, status: StatusComponent) -> void:
	assert(stats != null, "HealthComponent: missing StatsComponent")
	assert(status != null, "HealthComponent: missing StatusComponent")
	stats_component = stats
	status_component = status

func hurt(amount: float) -> void:
	if !status_component.is_alive or status_component.is_invulnerable or amount <= 0.0:
		return
	change_health(-amount)

func heal(amount: float) -> void:
	if !status_component.is_alive or amount <= 0.0:
		return
	change_health(amount)

func revive() -> void:
	if status_component.is_alive:
		return
	status_component.is_alive = true
	status_component.is_movable = true
	stats_component.current_health = stats_component.max_health
	revived.emit()

func change_health(amount: float) -> void:
	var old_health: float = stats_component.current_health
	stats_component.current_health = clampf(stats_component.current_health + amount, 0.0, stats_component.max_health)
	health_changed.emit(old_health, stats_component.current_health)

func trigger_death() -> void:
	if !status_component.is_alive:
		return
	status_component.is_alive = false
	status_component.is_movable = false
	died.emit()
