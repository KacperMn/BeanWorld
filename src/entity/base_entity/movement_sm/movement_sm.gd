class_name MovementSM extends StateMachine

# -- SEMI-CONSTANTS
var jump_force: float
var speed: float

# -- RETURN-VALUES --
var velocity: Vector3 = Vector3.ZERO
var rotation: Vector3 = Vector3.ZERO

# -- VARIABLES --
var position: Vector3
var is_on_floor: bool

func setup() -> void:
	if not provider:
		provider = MovementProvider.new()
	add_states([StandState.new(), FallState.new()])
	current_state = states[states.find(StandState)]
	super()

func set_movement_values(jf: float, sp: float, pos: Vector3, iof: bool) -> Dictionary:
	jump_force = jf
	speed = sp
	position = pos
	is_on_floor = iof
	return {
		"velocity": velocity,
		"rotation": rotation
	}

func _physics_process(delta: float) -> void:
	current_state.is_on_floor = is_on_floor
	super(delta)
	velocity = current_state.velocity
	rotation = current_state.rotation

func handle_state_entered(state: String) -> void:
	current_state.speed = speed
	current_state.velocity = velocity
	current_state.rotation = rotation
	if state == "DashState":
		current_state.position = position
	if state == "JumpState":
		get_state("JumpState").jump_force = jump_force
		
func _on_dead_entity() -> void:
	provider.enabled = false

func _on_revived_entity() -> void:
	provider.enabled = true
