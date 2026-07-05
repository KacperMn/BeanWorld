class_name VitalityState extends State

func enter() -> void:
    provider.health_changed.connect(_on_health_changed)
    provider.died.connect(_on_died)
    provider.revived.connect(_on_revived)
    on_enter()

func exit() -> void:
    provider.health_changed.disconnect(_on_health_changed)
    provider.died.disconnect(_on_died)
    provider.revived.disconnect(_on_revived)
    on_exit()

# hooks for subclasses
func on_enter() -> void: pass
func on_exit() -> void: pass
func handle(_delta: float) -> void: pass

func physics_update(delta: float) -> void:
    handle(delta)

# signal handlers — override in subclasses
func _on_health_changed(_old: float, _new: float) -> void: pass
func _on_died() -> void: pass
func _on_revived() -> void: pass