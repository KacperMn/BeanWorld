class_name NPC extends CombatCharacter

@onready var surroundings_component: SurroundingsComponent = $SurroundingsComponent

func _ready() -> void:
	movement_sm.provider = NPCMovementProvider.new()
	surroundings_component.setup()
	setup_activity_sm()
	super()

func setup_activity_sm() -> void:
	activity_sm.provider = NPCActivityProvider.new()
	activity_sm.add_states([WanderState.new(), InspectState.new(), ApproachState.new(), FlightState.new()])
	for state in activity_sm.states:
		if state is WanderState:
			activity_sm.current_state = state

func _physics_process(_delta: float) -> void:
	super(_delta)
	movement_sm.provider.set_npc_location_data(global_transform.origin, activity_sm.provider.target_location)
	activity_sm.provider.set_npc_location_data(global_transform.origin, self)
