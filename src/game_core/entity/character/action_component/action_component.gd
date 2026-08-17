class_name ActionComponent extends Node3D

@export var primary_action: PackedScene
@export var secondary_action: PackedScene
@export var ability_1: PackedScene
@export var ability_2: PackedScene
@export var ability_3: PackedScene
@export var ability_4: PackedScene

signal casting_changed(active: bool)
signal combat_entered

var action_slots: Dictionary[String, ActionSlot] = {}

func setup(owner_node: Character, facing: Node3D) -> void:
	var facing_node: Node3D = facing

	var slot_scenes: Dictionary[String, PackedScene] = {
		"primary": primary_action,
		"secondary": secondary_action,
		"ability_1": ability_1,
		"ability_2": ability_2,
		"ability_3": ability_3,
		"ability_4": ability_4,
	}

	for slot_name in slot_scenes:
		var scene: PackedScene = slot_scenes[slot_name]
		if scene == null:
			continue
		var slot := ActionSlot.new()
		add_child(slot)
		slot.setup(scene, slot_name, owner_node, facing_node)
		slot.casting_changed.connect(_on_slot_casting_changed)
		slot.combat_entered.connect(_on_slot_combat_entered)
		action_slots[slot_name] = slot

func try_use(slot_name: String) -> bool:
	if not action_slots.has(slot_name):
		return false
	if _any_other_slot_channeling(slot_name):
		return false
	return action_slots[slot_name].try_use()

func is_slot_ready(slot_name: String) -> bool:
	return action_slots.has(slot_name) and action_slots[slot_name].is_ready()

func get_action(slot_name: String) -> Action:
	if not action_slots.has(slot_name):
		return null
	return action_slots[slot_name].current_action

func _any_other_slot_channeling(slot_name: String) -> bool:
	for name in action_slots:
		if name != slot_name and action_slots[name].is_channeling():
			return true
	return false

func _on_slot_casting_changed(active: bool) -> void:
	casting_changed.emit(active)

func _on_slot_combat_entered() -> void:
	combat_entered.emit()
