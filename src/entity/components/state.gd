class_name State extends Resource

var state_name: String
var provider: Provider
signal change_state(new_state: String)
signal entered_state(state_name: String)

func enter() -> void:
	entered_state.emit(state_name)
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
