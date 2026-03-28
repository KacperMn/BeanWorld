class_name Bean extends Entity

@onready var timer = $Timer
var target_location

func _ready() -> void:
	movement_provider = NPCMovementProvider.new()
	movement_sm.setup(self , movement_provider)
	super ()

func _on_timer_timeout() -> void:
	print("Timer timeout, picking new target location")
	var range := 5.0
	var random_spot := Vector3(randf_range(-range, range), 0, randf_range(-range, range))
	target_location = global_transform.origin + random_spot

func _physics_process(delta: float) -> void:
	super (delta)
	if target_location and global_transform.origin.distance_to(target_location) < 0.5:
		target_location = null