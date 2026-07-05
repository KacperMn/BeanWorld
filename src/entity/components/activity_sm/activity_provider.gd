class_name ActivityProvider extends Provider

func get_combat_state() -> bool:
    if entity.is_in_combat:
        return true
    else:
        return false