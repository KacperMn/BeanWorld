extends Node

var TEST_WORLD_UID = preload("uid://cg2qbxupgei15")

signal back_to_main
signal exit_game

@onready var pause_menu = $PauseMenu

var test_world: Node

var paused: bool = true

func _ready() -> void:
	pause_menu.visible = paused

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and test_world != null:
		toggle_game_paused()
		get_viewport().set_input_as_handled()

func load_game(savefile: String) -> void:
	if savefile == "":
		test_world = TEST_WORLD_UID.instantiate()
		add_child(test_world)
	else:
		pass
	paused = true
	toggle_game_paused()

func unload_game() -> void:
	if test_world:
		test_world.queue_free()
		test_world = null

func toggle_game_paused() -> void:
	paused = !paused
	if paused:
		pause_menu.visible = paused
		get_tree().paused = paused
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		pause_menu.visible = paused
		get_tree().paused = paused
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func on_back_to_main() -> void:
	back_to_main.emit()

func quit() -> void:
	exit_game.emit()
