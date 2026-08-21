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
	movement_component.provider.path_position = navigation_agent.get_next_path_position()
	if movement_component.provider.toggle_sprint != behaviour_component.current_state.should_be_running:
		movement_component.provider.toggle_sprint = behaviour_component.current_state.should_be_running
	if navigation_agent.is_target_reached():
		movement_component.provider.clear_target()
		behaviour_component.arrived()

func on_new_target_location(target_location: Vector3) -> void:
	navigation_agent.target_position = target_location