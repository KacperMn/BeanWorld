class_name Relationship extends Resource

const MAX = 100.0
const MIN = -100.0
const DEFAULT = 0.0

@export var fondness: float = 60.0
@export var fear: float = DEFAULT

var interacted_recently: bool = false

func _init() -> void:
    pass

func change_fondness(amount: float) -> void:
    fondness = clampf(fondness + amount, MIN, MAX)

func change_fear(amount: float) -> void:
    fear = clampf(fear + amount, MIN, MAX)