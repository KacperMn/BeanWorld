extends Node

var TEST_WORLD_UID = preload("uid://cg2qbxupgei15")

signal back_to_main
signal exit_game

@onready var pause_menu = $PauseMenu

var test_world: Node

func _ready() -> void:
	pause_menu.back_to_main.connect(func(): back_to_main.emit())
	pause_menu.exit_game.connect(func(): exit_game.emit())

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("pause") and test_world != null:
		pause_menu.toggle_pause()
		get_viewport().set_input_as_handled()

func load_game(savefile: String) -> void:
	if savefile == "":
		test_world = TEST_WORLD_UID.instantiate()
		add_child(test_world)
	else:
		pass # start_game_from_save_file equivalent

func unload_game() -> void:
	if test_world:
		test_world.queue_free()
		test_world = null

func on_back_to_main() -> void:
	pass