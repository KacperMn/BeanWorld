class_name CameraMode extends Resource

@export var fov: float = 75.0
@export var distance: float = 5.0
@export var vertical_angle: float = -20.0
@export var follow_speed: float = 12.0
@export var mouse_sensitivity: float = 0.7
@export var transition_duration: float = 0.4
@export var mouse_controls_camera: bool = true
@export var min_pitch: float = -60.0
@export var max_pitch: float = 40.0

# called once when this mode becomes active
func on_enter(_controller: CameraController) -> void:
    pass

# called once when leaving this mode
func on_exit(_controller: CameraController) -> void:
    pass

# called every physics frame
func update(delta: float, controller: CameraController) -> void:
    handle_position(delta, controller)
    handle_rotation(delta, controller)

# called every physics frame for rotation logic
func handle_rotation(_delta: float, _controller: CameraController) -> void:
    pass

# called every physics frame for position logic
func handle_position(_delta: float, _controller: CameraController) -> void:
    pass