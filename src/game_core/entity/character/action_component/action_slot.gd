class_name ActionSlot extends Node3D

signal phase_changed(previous: String, current: String)
signal casting_changed(active: bool)
signal combat_entered

var slot_name: String = ""
var current_action: Action
var owner_entity: Character
var _facing_node: Node3D

func setup(action_scene: PackedScene, p_slot_name: String, owner_node: Character, facing_node: Node3D) -> void:
	slot_name = p_slot_name
	owner_entity = owner_node
	_facing_node = facing_node

	current_action = action_scene.instantiate() as Action
	add_child(current_action) # must be in tree before @onready/_ready-dependent logic runs
	current_action.configure(owner_node, _facing_node)
	current_action.phase_changed.connect(_on_action_phase_changed)
	current_action.on_casting.connect(_on_action_casting)
	current_action.combat_entered.connect(_on_action_combat_entered)

func _process(delta: float) -> void:
	if current_action:
		current_action.update(delta)

func try_use() -> bool:
	if not current_action:
		return false
	return current_action.try_use()

func is_ready() -> bool:
	return current_action != null and current_action.is_ready()

func is_channeling() -> bool:
	return current_action != null and current_action.is_channel \
		and current_action.phase == ActionPhase.ACTIVE

func get_forward() -> Vector3:
	var node := _facing_node if _facing_node else self
	return -node.global_transform.basis.z

func _on_action_phase_changed(previous: String, current: String) -> void:
	phase_changed.emit(previous, current)

func _on_action_casting(active: bool) -> void:
	casting_changed.emit(active)

func _on_action_combat_entered() -> void:
	combat_entered.emit()