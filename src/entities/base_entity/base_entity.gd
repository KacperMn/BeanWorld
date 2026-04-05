class_name Entity extends CharacterBody3D

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

# --- Stats ---
@export var max_health: float = 100.0
@export var base_speed: float = 10.0
@export var jump_force: float = 12.0

var is_in_combat: bool = false

var speed: float

# --- State Machines ---
@onready var movement_sm: MovementSM = $MovementSM
@onready var vitality_sm: VitalitySM = $VitalitySM

@onready var shape: CapsuleShape3D = $EntityCollider.shape

func _ready() -> void:
	speed = base_speed
	movement_sm.setup()
	vitality_sm.setup()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity.y -= gravity * delta
	move_and_slide()

func hurt(amount: float) -> void:
	vitality_sm.hurt(amount)
	enter_combat()

func heal(amount: float) -> void:
	vitality_sm.heal(amount)

func enter_combat() -> void:
	if vitality_sm.health_provider.is_dead:
		return
	if !is_in_combat:
		is_in_combat = true
		print("Entered combat")
		var combat_timer = Timer.new()
		combat_timer.wait_time = 5.0
		combat_timer.one_shot = true
		combat_timer.connect("timeout", Callable(self, "exit_combat"))
		add_child(combat_timer)
		combat_timer.start()
	else:
		var combat_timer = get_node_or_null("Timer")
		if combat_timer:
			combat_timer.start()

func exit_combat() -> void:
	print("Exited combat")
	is_in_combat = false

var entity_height: float:
	get: return shape.height if shape else 2.0
var entity_radius: float:
	get: return shape.radius if shape else 0.5
