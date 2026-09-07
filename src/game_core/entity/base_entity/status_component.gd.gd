class_name StatusComponent extends Resource

var is_alive: bool
var is_in_combat: bool
var is_invulnerable: bool

func _init() -> void:
    set_is_alive(true)
    set_is_in_combat(false)
    set_is_invulnerable(false)

func set_is_alive(value: bool) -> void:
    is_alive = value

func set_is_in_combat(value: bool) -> void:
    is_in_combat = value

func set_is_invulnerable(value: bool) -> void:
    is_invulnerable = value