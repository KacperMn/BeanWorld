class_name PlayerController extends Controller

var camera_arm: Node3D
var movement: MovementComponent
var action_component: ActionComponent
var playmode_sm: PlayModeSM

const Inputs = {
	"move_left": "move_left",
	"move_right": "move_right",
	"move_forward": "move_forward",
	"move_back": "move_back",
	"switch_camera_mode": "switch_camera_mode",
	"sprint": "sprint",
	"jump": "jump",
	"primary_action": "primary_action",
	"secondary_action": "secondary_action",
	"ability_1": "ability_1",
	"ability_2": "ability_2",
	"ability_3": "ability_3",
	"ability_4": "ability_4"
}

func setup(_camera_arm: Node3D, _movement: MovementComponent, _action_component: ActionComponent, _playmode_sm: PlayModeSM) -> void:
	camera_arm = _camera_arm
	movement = _movement
	action_component = _action_component
	playmode_sm = _playmode_sm

func _input(event: InputEvent) -> void:
	if event.is_action_pressed(Inputs.switch_camera_mode):
		playmode_sm.switch_playmode()
	elif event.is_action_pressed(Inputs.primary_action):
		action_component.try_use(action_component.ActionSlotName.PRIMARY_ACTION)
	elif event.is_action_pressed(Inputs.secondary_action):
		action_component.try_use(action_component.ActionSlotName.SECONDARY_ACTION)
	elif event.is_action_pressed(Inputs.ability_1):
		action_component.try_use(action_component.ActionSlotName.ABILITY_1)
	elif event.is_action_pressed(Inputs.ability_2):
		action_component.try_use(action_component.ActionSlotName.ABILITY_2)
	elif event.is_action_pressed(Inputs.ability_3):
		action_component.try_use(action_component.ActionSlotName.ABILITY_3)
	elif event.is_action_pressed(Inputs.ability_4):
		action_component.try_use(action_component.ActionSlotName.ABILITY_4)

func _process(_delta: float) -> void:
	process_movement_input()

func process_movement_input() -> void:
	var input_dir := Input.get_vector(
		Inputs.move_left,
		Inputs.move_right,
		Inputs.move_forward,
		Inputs.move_back
	)
	var dir := camera_arm.global_transform.basis * Vector3(input_dir.x, 0, input_dir.y)
	dir.y = 0.0
	movement.set_move_direction(dir.normalized())
	movement.toggle_sprint(Input.is_action_pressed(Inputs.sprint))
	if Input.is_action_pressed(Inputs.jump):
		movement.jump()