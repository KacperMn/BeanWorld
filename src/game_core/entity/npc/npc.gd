class_name NPC extends Character

@onready var behaviour_component: BehaviourComponent = $BehaviourComponent
@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

func _ready() -> void:
	super()
	behaviour_component.new_target_location.connect(on_new_target_location)
	behaviour_component.setup(stats_component, status_component, awareness_component)

func _physics_process(_delta: float) -> void:
	movement_component.provider.path_position = navigation_agent.get_next_path_position()
	if navigation_agent.is_target_reached():
		movement_component.provider.should_walk = false
		behaviour_component.arrived()

func on_new_target_location(target_location: Vector3) -> void:
	print(target_location)
	navigation_agent.target_position = target_location
	movement_component.provider.should_walk = true
