class_name Action extends Node3D

signal phase_changed(previous: String, current: String)
signal on_casting(active: bool)
signal combat_entered

@export var action_name: String = ""
@export var cast_time: float = 0.0
@export var active_time: float = 0.0
@export var recovery_time: float = 1.0
@export var cooldown_time: float = 0.0
@export var is_channel: bool = false
@export var can_move: bool = true

var phase: String = ActionPhase.READY
var _timer: float = 0.0
var _cooldown_timer: float = 0.0
var _owner: Character
var forward_node: Node3D = self

func configure(owner: Character, forward: Node3D = null) -> void:
	_owner = owner
	if forward:
		forward_node = forward

func update(delta: float) -> void:
	if _cooldown_timer > 0.0:
		_cooldown_timer -= delta

	if phase == ActionPhase.READY:
		return
	_timer -= delta
	if _timer <= 0.0:
		_enter_phase(_next_phase())

func try_use() -> bool:
	if not is_ready():
		return false
	if not can_move:
		on_casting.emit(true)
	_cooldown_timer = cooldown_time
	_enter_phase(ActionPhase.CASTING if cast_time > 0.0 else ActionPhase.ACTIVE)
	return true

func cancel() -> void:
	if phase == ActionPhase.CASTING:
		_enter_phase(ActionPhase.RECOVERY)

func is_ready() -> bool:
	return phase == ActionPhase.READY and _cooldown_timer <= 0.0

func is_on_cooldown() -> bool:
	return _cooldown_timer > 0.0

func cooldown_remaining() -> float:
	return maxf(_cooldown_timer, 0.0)

func apply_effects(effects: Array[ActionEffect], target: Entity) -> void:
	for effect in effects:
		effect.apply(target, _owner)
		if effect.enters_combat:
			combat_entered.emit()

func _next_phase() -> String:
	match phase:
		ActionPhase.CASTING:
			return ActionPhase.ACTIVE
		ActionPhase.ACTIVE:
			return ActionPhase.RECOVERY
		_:
			return ActionPhase.READY

func on_cast_start() -> void:
	pass

func on_activate() -> void:
	pass

func on_recovery_start() -> void:
	pass

func _enter_phase(new_phase: String) -> void:
	var previous := phase
	phase = new_phase
	phase_changed.emit(previous, new_phase)

	if new_phase == ActionPhase.READY:
		if not can_move:
			on_casting.emit(false)
		return

	match new_phase:
		ActionPhase.CASTING:
			_timer = cast_time
			on_cast_start()
		ActionPhase.ACTIVE:
			_timer = active_time
			on_activate()
		ActionPhase.RECOVERY:
			_timer = recovery_time
			on_recovery_start()

	if _timer <= 0.0:
		_enter_phase(_next_phase())