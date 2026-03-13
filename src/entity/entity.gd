class_name Entity extends CharacterBody3D

signal health_changed(old_value: float, new_value: float)
signal died()

@export var max_health: float = 100.0
@export var speed: float = 5.0
@export var invincibility_duration: float = 0.0

var health: float
var is_dead: bool = false
var is_invincible: bool = false

@onready var _invincibility_timer: Timer = $InvincibilityTimer
@onready var state_machine: StateMachine = $StateMachine

func _ready() -> void:
	health = max_health
	_invincibility_timer.wait_time = invincibility_duration
	_invincibility_timer.one_shot = true
	_invincibility_timer.timeout.connect(_on_invincibility_expired)

func hurt(amount: float) -> void:
	if is_dead or is_invincible:
		return
	var old_health := health
	health = clampf(health - amount, 0.0, max_health)
	health_changed.emit(old_health, health)
	if health <= 0.0:
		_trigger_death()
	elif invincibility_duration > 0.0:
		_start_invincibility()

func heal(amount: float) -> void:
	if is_dead:
		return
	var old_health := health
	health = clampf(health + amount, 0.0, max_health)
	health_changed.emit(old_health, health)

func die() -> void:
	pass # override in subclasses

func _trigger_death() -> void:
	if is_dead:
		return
	is_dead = true
	died.emit()
	die()

func _start_invincibility() -> void:
	is_invincible = true
	_invincibility_timer.start()

func _on_invincibility_expired() -> void:
	is_invincible = false
