class_name MovementComponent extends StateMachine

var stats_component: StatsComponent
var character_body: CharacterBody3D

var move_direction: Vector3 = Vector3.ZERO
var sprint_toggle: bool = false


func setup(stats: StatsComponent, status: StatusComponent, character: CharacterBody3D) -> void:
    assert(stats != null); assert(status != null); assert(character != null)
    stats_component = stats
    character_body = character
    setup_sm()

func setup_sm() -> void:
    add_states([StandState.new(), FallState.new(), WalkState.new(), JumpState.new(), SprintState.new()])
    current_state = get_state("StandState")
    for state in states:
        state.stats_component = stats_component
        state.character_body = character_body
        state.movement_sm = self
    super()

func _physics_process(_delta: float) -> void:
    super(_delta)
    character_body.move_and_slide()

func set_move_direction(dir: Vector3) -> void: move_direction = dir
func toggle_sprint(value: bool) -> void: sprint_toggle = value
func jump() -> void:
    if current_state is GroundedState && current_state is not FallState && current_state is not JumpState:
        transition_to("JumpState")

func get_move_direction() -> Vector3:
    return move_direction
func wants_sprint() -> bool:
    return sprint_toggle