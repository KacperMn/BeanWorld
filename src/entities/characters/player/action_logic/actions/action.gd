class_name Action extends Resource

@export var action_name: String = ""
@export var cast_time: float = 0.0
@export var active_time: float = 0.0
@export var recovery_time: float = 1.0
@export var is_channel: bool = false
@export var can_move: bool = true

var phase: String = ActionPhase.READY
var _timer: float = 0.0
var _slot: ActionSlot

func update(delta: float) -> void:
	match phase:
		ActionPhase.CASTING:
			_timer -= delta
			if _timer <= 0.0:
				_enter_active()
		ActionPhase.ACTIVE:
			if active_time > 0.0:
				_timer -= delta
				if _timer <= 0.0:
					_enter_recovery()
		ActionPhase.RECOVERY:
			_timer -= delta
			if _timer <= 0.0:
				phase = ActionPhase.READY
	

func try_use() -> bool:
	if phase != ActionPhase.READY:
		return false
	if cast_time > 0.0:
		_enter_cast()
	else:
		_enter_active()
	return true

func cancel() -> void:
	if phase == ActionPhase.CASTING:
		_enter_recovery()

func is_ready() -> bool:
	return phase == ActionPhase.READY

func on_cast_start() -> void:
	pass

func on_activate() -> void:
	pass

func on_recovery_start() -> void:
	pass

func _enter_cast() -> void:
	phase = ActionPhase.CASTING
	_timer = cast_time
	if not can_move:
		_slot.entity.disable_movement()
	on_cast_start()

func _enter_active() -> void:
	phase = ActionPhase.ACTIVE
	_timer = active_time
	on_activate()
	if active_time == 0.0:
		_enter_recovery()

func _enter_recovery() -> void:
	phase = ActionPhase.RECOVERY
	_timer = recovery_time
	if not can_move:
		_slot.entity.enable_movement()
	on_recovery_start()
