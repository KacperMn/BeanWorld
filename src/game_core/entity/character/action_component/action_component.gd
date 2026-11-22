class_name ActionComponent extends Node3D

@export var primary_action: PackedScene
@export var secondary_action: PackedScene
@export var ability_1: PackedScene
@export var ability_2: PackedScene
@export var ability_3: PackedScene
@export var ability_4: PackedScene

enum ActionSlotName {
	PRIMARY_ACTION,
	SECONDARY_ACTION,
	ABILITY_1,
	ABILITY_2,
	ABILITY_3,
	ABILITY_4
}

signal casting_changed(active: bool)
signal combat_entered

var action_slots: Dictionary[ActionSlotName, ActionSlot] = {}

func setup(owner_node: Character, facing: Node3D) -> void:
	var facing_node: Node3D = facing

	global_transform.origin = facing.global_transform.origin

	var slot_scenes: Dictionary[ActionSlotName, PackedScene] = {
		ActionSlotName.PRIMARY_ACTION: primary_action,
		ActionSlotName.SECONDARY_ACTION: secondary_action,
		ActionSlotName.ABILITY_1: ability_1,
		ActionSlotName.ABILITY_2: ability_2,
		ActionSlotName.ABILITY_3: ability_3,
		ActionSlotName.ABILITY_4: ability_4
	}

	for action_slot_name in ActionSlotName.values():
		if slot_scenes[action_slot_name] == null:
			continue
		var slot := ActionSlot.new()
		add_child(slot)
		slot.setup(slot_scenes[action_slot_name], owner_node, facing_node)
		slot.casting_changed.connect(_on_slot_casting_changed)
		slot.combat_entered.connect(_on_slot_combat_entered)
		action_slots[action_slot_name] = slot

func try_use(slot_name: ActionSlotName) -> bool:
	if not action_slots.has(slot_name):
		return false
	if _any_other_slot_channeling(slot_name):
		return false
	return action_slots[slot_name].try_use()

func is_slot_ready(slot_name: ActionSlotName) -> bool:
	return action_slots.has(slot_name) and action_slots[slot_name].is_ready()

func get_action(slot_name: ActionSlotName) -> Action:
	if not action_slots.has(slot_name):
		return null
	return action_slots[slot_name].current_action

func _any_other_slot_channeling(slot_name: ActionSlotName) -> bool:
	for action_slot in action_slots:
		if action_slot != slot_name and action_slots[action_slot].is_channeling():
			return true
	return false

func _on_slot_casting_changed(active: bool) -> void:
	casting_changed.emit(active)

func _on_slot_combat_entered() -> void:
	combat_entered.emit()
