class_name CombatComponent extends Node

signal entered_combat()
signal left_combat()

@onready var combat_timer: Timer = $CombatTimer

var status_component: StatusComponent

func setup(status: StatusComponent) -> void:
	assert(status != null, "CombatComponent: Missing StatusComponent")
	status_component = status

func enter_combat() -> void:
	if !status_component.is_alive:
		return
	if !status_component.is_in_combat:
		combat_timer.start()
		status_component.is_in_combat = true
		entered_combat.emit()
	else:
		combat_timer.start()

func exit_combat() -> void:
	if status_component.is_in_combat:
		status_component.is_in_combat = false
		left_combat.emit()