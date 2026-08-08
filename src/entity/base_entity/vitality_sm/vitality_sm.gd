class_name VitalitySM extends StateMachine

signal health_changed(old_value: float, new_value: float)
signal died()
signal revived()

var max_health: float
var health: float
var is_dead: bool = false

func setup() -> void:
    add_states([AliveState.new(), DeadState.new(), HurtState.new()])
    current_state = states[states.find(AliveState)]
    super()

func setup_health_data(_max_health: float) -> void:
    max_health = _max_health
    health = max_health

func hurt(amount: float) -> void:
    if is_dead or current_state.is_invincible or amount <= 0.0:
        return
    _change_health(-amount)
    transition_to("HurtState")
    if health <= 0.0:
        _trigger_death()

func heal(amount: float) -> void:
    if is_dead or amount <= 0.0:
        return
    _change_health(amount)

func revive() -> void:
    if not is_dead:
        return
    is_dead = false
    health = max_health
    revived.emit()
    transition_to("AliveState")

func _change_health(amount: float) -> void:
    var old := health
    health = clampf(health + amount, 0.0, max_health)
    health_changed.emit(old, health)

func _trigger_death() -> void:
    if is_dead:
        return
    is_dead = true
    died.emit()
    transition_to("DeadState")