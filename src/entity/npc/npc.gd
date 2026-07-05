class_name NPC extends CombatCharacter

func _ready() -> void:
	movement_sm.provider = NPCMovementProvider.new()
	setup_activity_sm()
	super()

func setup_activity_sm() -> void:
	activity_sm.provider = NPCActivityProvider.new()
	activity_sm.add_states([WanderState.new(), InspectState.new(), ApproachState.new(), FlightState.new()])
	for state in activity_sm.states:
		if state is WanderState:
			activity_sm.current_state = state