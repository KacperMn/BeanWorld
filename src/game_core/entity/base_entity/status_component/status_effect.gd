class_name StatusEffect extends Node

var target: Entity
var instigator: Entity
var duration: float

func _init(_target: Entity, _instigator: Entity, _duration: float = 1.0) -> void:
    target = _target
    instigator = _instigator
    duration = _duration

func _ready() -> void:
    var timer: Timer = Timer.new()
    timer.wait_time = 1.0
    timer.one_shot = false
    timer.connect("timeout", Callable(self, "_on_dot_timer_timeout"))
    add_child(timer)
    timer.start()

func _on_dot_timer_timeout() -> void:
    apply()
    duration -= 1.0
    if duration <= 0.0:
        queue_free()

func apply() -> void:
    pass