class_name Provider extends Resource

var entity: Entity

func _setup(_entity: Entity) -> void:
    entity = _entity
    setup()

func setup() -> void:
    pass