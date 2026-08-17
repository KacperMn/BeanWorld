class_name Entity extends CharacterBody3D

@export var stats_component: StatsComponent
@onready var status_component: StatusComponent = StatusComponent.new()

@onready var shape: CapsuleShape3D = $EntityCollider.shape

@onready var health_component: HealthComponent = $HealthComponent
@onready var combat_component: CombatComponent = $CombatComponent
@onready var movement_component: MovementSM = $MovementComponent

@onready var hud: EntityHUD = $EntityHUD

func _ready() -> void:
	health_component.setup(stats_component, status_component)
	combat_component.setup(status_component)
	movement_component.setup(stats_component, status_component, self as CharacterBody3D)
	setup_hud()

func hurt(amount: float, instigator: Node3D = null) -> void:
	health_component.hurt(amount)
	if instigator:
		combat_component.enter_combat()

func heal(amount: float) -> void:
	health_component.heal(amount)

func setup_hud() -> void:
	hud.setup(stats_component, shape)
	health_component.health_changed.connect(hud._on_health_changed)