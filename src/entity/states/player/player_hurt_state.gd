class_name PlayerHurtState extends HurtState

func on_enter() -> void:
    entity.velocity = Vector3.ZERO

func on_expired() -> void:
    entity.state_machine.transition_to(entity.idle_state)