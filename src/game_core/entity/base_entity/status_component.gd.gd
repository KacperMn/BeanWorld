class_name StatusComponent extends Resource

var is_alive: bool
var is_in_combat: bool
var is_invulnerable: bool

func _init() -> void:
    is_alive = true
    is_in_combat = false
    is_invulnerable = false