class_name FacingDirectionNode extends Node3D

@onready var facing_ray: RayCast3D = $FacingRayCast

func setup(shape: CapsuleShape3D) -> void:
    facing_ray.position.z = (shape.radius + 0.1) * -1