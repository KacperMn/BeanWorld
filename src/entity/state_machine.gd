class_name StateMachine extends Node

signal state_changed(new_state: State)

var current_state: State
var _entity: Entity

func start(initial: State, entity: Entity) -> void:
	_entity = entity
	_entity.health_changed.connect(_on_health_changed)
	_entity.died.connect(_on_died)
	current_state = initial
	current_state.enter()

func transition_to(new_state: State) -> void:
	if new_state == current_state:
		return
	current_state.exit()
	current_state = new_state
	current_state.enter()
	state_changed.emit(current_state)

func _on_health_changed(old_val: float, new_val: float) -> void:
	if new_val < old_val and not _entity.is_dead:
		transition_to(_entity.hurt_state)

func _on_died() -> void:
	transition_to(_entity.dead_state)

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)
