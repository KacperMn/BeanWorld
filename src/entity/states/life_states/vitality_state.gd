class_name VitalityState extends State

var vitality_sm: VitalityStateMachine

func physics_update(_delta: float) -> void:
	if entity.health <= 0.0 and state_name != "DeadState":
		entity.die()

	if Input.is_action_just_pressed("damage"):
		entity.hurt(10.0)
	
	if Input.is_action_just_pressed("kill"):
		entity.hurt(entity.health)

	if Input.is_action_just_pressed("revive"):
		entity.revive()
	handle(_delta)

func handle(_delta: float) -> void:
	pass

func on_hurt(damage: float) -> void:
	if vitality_sm.current_state.state_name == "DeadState":
		print("Can't hurt a dead man.")
		return
	entity.change_health(-damage)
	print("Ouch! Took ", damage, " damage.")
	if vitality_sm.current_state.state_name != "HurtState":
		entity.vitality_sm.transition_to("HurtState")

func on_heal(amount: float) -> void:
	if vitality_sm.current_state.state_name == "DeadState":
		print("Can't heal a dead man.")
		return
	entity.change_health(amount)

func revive() -> void:
	if vitality_sm.current_state.state_name != "DeadState":
		print("Already alive.")
		return
	entity.change_health(entity.max_health)
	entity.vitality_sm.transition_to("AliveState")
