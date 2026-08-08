class_name Entity extends CharacterBody3D

# --- Stats ---
var max_health: float = 100.0
var health: float:
	get: return vitality_sm.health
var base_speed: float = 10.0
var speed: float
@onready var jump_force: float = 12.0

@onready var shape: CapsuleShape3D = $EntityCollider.shape
var entity_height: float:
	get: return shape.height if shape else 2.0
var entity_radius: float:
	get: return shape.radius if shape else 0.5

# --- Components ---
@onready var movement_sm: MovementSM = $MovementSM
@onready var vitality_sm: VitalitySM = $VitalitySM
@onready var combat_sm: CombatSM = $CombatSM
@onready var hud: EntityHUD = $EntityHUD

var is_in_combat: bool:
	get: return combat_sm.current_state is InCombatState
var is_dead: bool:
	get: return vitality_sm.is_dead

func _ready() -> void:
	setup_health_components()
	setup_movement_components()
	combat_sm.setup()

func _physics_process(delta: float) -> void:
	process_movement()
	combat_sm.set_combat_data(is_dead)

func hurt(amount: float) -> void:
	vitality_sm.hurt(amount)
	combat_sm.enter_combat()

func heal(amount: float) -> void:
	vitality_sm.heal(amount)

func setup_health_components() -> void:
	health = max_health
	vitality_sm.health_changed.connect(hud._on_health_changed)
	hud.setup_healthbar(max_health, entity_height)
	vitality_sm.setup_health_data(max_health)
	vitality_sm.setup()

func setup_movement_components() -> void:
	speed = base_speed
	vitality_sm.died.connect(movement_sm._on_dead_entity)
	vitality_sm.revived.connect(movement_sm._on_revived_entity)
	movement_sm.setup()

func process_movement() -> void:
	movement_sm.jump_force = jump_force
	movement_sm.speed = speed
	movement_sm.position = position
	movement_sm.is_on_floor = is_on_floor()
	velocity = movement_sm.velocity
	rotation = movement_sm.rotation
	move_and_slide()
