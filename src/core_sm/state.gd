class_name State extends Resource

var state_name: String
var entity: Entity
var state_machine: StateMachine
var provider: Provider

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
