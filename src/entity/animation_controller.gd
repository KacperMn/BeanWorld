class_name AnimationController extends Node

@onready var anim_tree: AnimationTree

# override or set via @export per character
@export var state_animations: Dictionary = {
	"IdleState": "idle",
	"WalkState": "walk",
	"JumpState": "jump",
	"HurtState": "hurt",
	"DeadState": "death",
	"AttackState": "attack",
}

func _ready() -> void:
	call_deferred("_connect_state_machine")
	anim_tree = get_owner().get_node("AnimationTree")

func _connect_state_machine() -> void:
	var movement_sm: MovementStateMachine = get_parent().movement_sm
	movement_sm.state_changed.connect(_on_state_changed)


func _on_state_changed(new_state: State) -> void:
	var anim: String = state_animations.get(new_state.state_name, "")
	if anim != "":
		anim_tree.set("parameters/state/current", anim)
