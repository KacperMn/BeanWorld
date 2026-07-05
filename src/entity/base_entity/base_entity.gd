class_name Entity extends CharacterBody3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

# --- Stats ---
@export var max_health: float = 100.0
@export var base_speed: float = 10.0
@export var jump_force: float = 12.0

var speed: float

# --- State Machines ---
@onready var movement_sm: MovementSM = $MovementSM
@onready var vitality_sm: VitalitySM = $VitalitySM
@onready var combat_sm: CombatSM = $CombatSM

@onready var shape: CapsuleShape3D = $EntityCollider.shape
var entity_height: float:
	get: return shape.height if shape else 2.0
var entity_radius: float:
	get: return shape.radius if shape else 0.5

var is_in_combat: bool:
	get: return combat_sm.current_state is InCombatState
var is_dead: bool:
	get: return vitality_sm.provider.is_dead

func _ready() -> void:
	speed = base_speed
	movement_sm.setup()
	vitality_sm.setup()
	combat_sm.setup()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	move_and_slide()

func hurt(amount: float) -> void:
	vitality_sm.hurt(amount)
	combat_sm.enter_combat()

func heal(amount: float) -> void:
	vitality_sm.heal(amount)
