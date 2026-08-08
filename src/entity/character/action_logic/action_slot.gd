class_name ActionSlot extends Node

var entity: Entity
var current_action: Action = null

func _process(delta: float) -> void:
	if current_action:
		current_action.update(delta)

func try_use() -> bool:
	if not current_action:
		return false
	if _any_slot_channeling():
		return false
	return current_action.try_use()

func _any_slot_channeling() -> bool:
	for slot in entity.action_component.slots:
		if slot.current_action and \
		   slot.current_action.is_channel and \
		   slot.current_action.phase == ActionPhase.ACTIVE:
			return true
	return false
