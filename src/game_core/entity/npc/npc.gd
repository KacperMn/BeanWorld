class_name NPC extends Character

@onready var behaviour_component: BehaviourComponent = $BehaviourComponent
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

func _ready() -> void:
	super()
	behaviour_component.new_target_location.connect(on_new_target_location)
	behaviour_component.setup(stats_component, status_component, awareness_component)

func _physics_process(_delta: float) -> void:
	process_movement_behaviour()
	
func process_movement_behaviour() -> void:
	var next := navigation_agent.get_next_path_position()
	var dir := next - global_transform.origin
	dir.y = 0.0
	movement_component.set_move_direction(dir.normalized() if not navigation_agent.is_target_reached() else Vector3.ZERO)
	movement_component.toggle_sprint(behaviour_component.current_state.should_be_running)
	if navigation_agent.is_target_reached():
		behaviour_component.arrived()

func on_new_target_location(target_location: Vector3) -> void:
	navigation_agent.target_position = target_location