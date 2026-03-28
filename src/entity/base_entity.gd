class_name Entity extends CharacterBody3D

# --- Stats ---
@export var max_health: float = 100.0
@export var base_speed: float = 10.0
@export var gravity: float = 26.0
@export var jump_force: float = 12.0

# --- Runtime ---
var health: float
var speed: float
var is_dead: bool = false

# --- State Machines ---
@onready var movement_sm: MovementStateMachine = $MovementStateMachine
@onready var vitality_sm: VitalityStateMachine = $VitalityStateMachine
var movement_provider: MovementProvider

func _ready() -> void:
	health = max_health
	speed = base_speed
	vitality_sm.setup(self )

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta * 1.8
	move_and_slide()

func change_health(amount: float) -> void:
	health = clamp(health + amount, 0.0, max_health)
	print("Health changed by ", amount, ". Current health: ", health)

func hurt(amount: float) -> void:
	vitality_sm.current_state.on_hurt(amount)

func heal(amount: float) -> void:
	vitality_sm.current_state.on_heal(amount)

func die() -> void:
	if not is_dead:
		is_dead = true
		print("Entity has died.")
		vitality_sm.transition_to("DeadState")

func revive() -> void:
	if is_dead:
		is_dead = false
		print("Entity has been revived.")
		vitality_sm.current_state.revive()
