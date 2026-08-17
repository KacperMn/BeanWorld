class_name BehaviourState extends State

signal new_interacting_character(character: Character)

var stats_component: StatsComponent
var status_component: StatusComponent
var awareness_component: AwarenessComponent

var interacting_character: Character:
	set(value):
		new_interacting_character.emit(value)
		interacting_character = value

var arrived: bool = true

signal new_target_location(target_location: Vector3)

var target_location: Vector3:
	set(value):
		target_location = value
		new_target_location.emit(target_location)