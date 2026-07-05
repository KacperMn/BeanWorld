class_name VitalitySM extends StateMachine

func setup() -> void:
    provider = HealthProvider.new()
    add_states([AliveState.new(), DeadState.new(), HurtState.new()])
    current_state = states[states.find(AliveState)]
    super ()

func hurt(amount: float) -> void:
    provider.hurt(amount)

func heal(amount: float) -> void:
    provider.heal(amount)

func revive() -> void:
    provider.revive()