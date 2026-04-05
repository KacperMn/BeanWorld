class_name RangeQuery extends Resource

@export var radius: float = 2.0
@export var cone_angle: float = 360.0  # 360 = full sphere
@export var height_offset: float = 0.0  # vertical center offset
@export var collision_mask: int = 1

func get_entities_in_range(origin: Entity, forward: Vector3 = Vector3.ZERO) -> Array[Entity]:
    var results: Array[Entity] = []
    var space := origin.get_world_3d().direct_space_state
    var center := origin.global_position + Vector3(0, height_offset, 0)

    var params := PhysicsShapeQueryParameters3D.new()
    var shape := SphereShape3D.new()
    shape.radius = radius
    params.shape = shape
    params.transform = Transform3D(Basis(), center)
    params.collision_mask = collision_mask
    params.exclude = [origin.get_rid()]

    var hits := space.intersect_shape(params)

    for hit in hits:
        var body = hit.collider
        if not body is Entity:
            continue
        if cone_angle < 360.0:
            if not _in_cone(center, body.global_position, forward):
                continue
        results.append(body)

    return results

func get_bodies_in_range(origin: Node3D) -> Array:
    var results := []
    var space := origin.get_world_3d().direct_space_state
    var center := origin.global_position + Vector3(0, height_offset, 0)

    var params := PhysicsShapeQueryParameters3D.new()
    var shape := SphereShape3D.new()
    shape.radius = radius
    params.shape = shape
    params.transform = Transform3D(Basis(), center)
    params.collision_mask = collision_mask
    params.exclude = [origin.get_rid()]

    return space.intersect_shape(params)

func has_line_of_sight(origin: Node3D, target: Node3D) -> bool:
    var space := origin.get_world_3d().direct_space_state
    var params := PhysicsRayQueryParameters3D.new()
    params.from = origin.global_position + Vector3(0, height_offset, 0)
    params.to = target.global_position + Vector3(0, height_offset, 0)
    params.exclude = [origin.get_rid()]
    params.collision_mask = collision_mask
    var result := space.intersect_ray(params)
    return result.is_empty() or result.collider == target

func is_in_range(origin: Node3D, target: Node3D) -> bool:
    return origin.global_position.distance_to(target.global_position) <= radius

func _in_cone(origin: Vector3, target_pos: Vector3, forward: Vector3) -> bool:
    if forward == Vector3.ZERO:
        return true
    var to_target := target_pos - origin
    to_target.y = 0.0
    if to_target.length() < 0.001:
        return true
    to_target = to_target.normalized()
    var fwd := forward
    fwd.y = 0.0
    fwd = fwd.normalized()
    return fwd.dot(to_target) >= cos(deg_to_rad(cone_angle / 2.0))