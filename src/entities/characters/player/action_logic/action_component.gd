class_name ActionComponent extends Node

@export var slot_actions: Array[Action] = []

var entity: Entity
var slots: Array[ActionSlot] = []

func _ready() -> void:
    entity = get_parent()
    for action in slot_actions:
        var slot := ActionSlot.new()
        slot.entity = entity
        slot.current_action = action.duplicate()
        slot.current_action._slot = slot
        slots.append(slot)
        add_child(slot)

func try_use(index: int) -> void:
    if index >= slots.size():
        return
    slots[index].try_use()

func get_action(index: int) -> Action:
    if index >= slots.size():
        return null
    return slots[index].current_action

func _input(event: InputEvent) -> void:
    if event.is_action_pressed("attack"):
        try_use(0)