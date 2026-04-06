class_name ActivityState extends State

func update(_delta: float) -> void:
    provider.get_is_in_combat(state_name)
    provider.get_wants_to_build(state_name)