class_name CameraController extends Node3D

@export var exploration_mode: ExplorationCameraMode
@export var combat_mode: CombatCameraMode
@export var building_mode: BuildingCameraMode
@onready var default_mode: CameraMode = exploration_mode

# exposed so modes can read/write them directly
var yaw: float = 0.0
var pitch: float = 0.0
var input_direction: Vector2 = Vector2.ZERO
var vertical_offset: float = 0.0

var _current_mode: CameraMode
var _tween: Tween
var _active_fov: float = 75.0
var _active_distance: float = 5.0

@onready var camera_arm: Node3D = $CameraArm
@onready var camera_boom: SpringArm3D = $CameraArm/CameraBoom
@onready var camera: Camera3D = $CameraArm/CameraBoom/Camera3D
@onready var target: Player = get_parent()

func _ready() -> void:
	top_level = true
	camera.position.z = 0.0
	if default_mode:
		set_mode(default_mode, false)

func set_mode(mode: CameraMode, animate: bool = true) -> void:
	if _current_mode:
		_current_mode.on_exit(self )
	_current_mode = mode
	_current_mode.on_enter(self )

	if _tween:
		_tween.kill()
	_tween = create_tween().set_parallel(true)
	var duration := mode.transition_duration if animate else 0.0
	_tween.tween_property(self , "_active_fov", mode.fov, duration)
	_tween.tween_property(self , "_active_distance", mode.distance, duration)

	pitch = deg_to_rad(mode.vertical_angle)

func _input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_ESCAPE:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if \
				Input.mouse_mode == Input.MOUSE_MODE_CAPTURED else \
				Input.MOUSE_MODE_CAPTURED
			return
	if not _current_mode or not _current_mode.mouse_controls_camera:
		return
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		input_direction = event.screen_relative * _current_mode.mouse_sensitivity
	if Input.is_action_just_pressed("switch_camera_mode"):
			if _current_mode == exploration_mode and combat_mode:
				set_mode(combat_mode)
			elif _current_mode == combat_mode and building_mode:
				set_mode(building_mode)
			elif _current_mode == building_mode and exploration_mode:
				set_mode(exploration_mode)

func _physics_process(delta: float) -> void:
	if not target or not _current_mode:
		return
	_current_mode.update(delta, self )
	_apply_active_values()
	input_direction = Vector2.ZERO

func _apply_active_values() -> void:
	camera.fov = _active_fov
	camera_boom.spring_length = _active_distance
	camera_boom.rotation.x = pitch
	camera_arm.rotation.y = yaw
