class_name HealthProvider extends Provider

signal health_changed(old_value: float, new_value: float)
signal died()
signal revived()

var max_health: float = 100.0
var health: float = 100.0
var is_dead: bool = false
var is_invincible: bool = false

func setup() -> void:
	max_health = entity.max_health
	health = entity.max_health

func hurt(amount: float) -> void:
	if is_dead or is_invincible or amount <= 0.0:
		return
	_change_health(-amount)
	if health <= 0.0:
		_trigger_death()

func heal(amount: float) -> void:
	if is_dead or amount <= 0.0:
		return
	_change_health(amount)

func revive() -> void:
	if not is_dead:
		return
	is_dead = false
	_change_health(max_health)
	revived.emit()

func _change_health(amount: float) -> void:
	var old := health
	health = clampf(health + amount, 0.0, max_health)
	health_changed.emit(old, health)

func _trigger_death() -> void:
	if is_dead:
		return
	is_dead = true
	died.emit()
