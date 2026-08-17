# Main.gd
extends Node

var MAIN_MENU_UID = preload("uid://og0gtlg177wk")

@onready var game_core = $GameCore

var main_menu: Control

func _ready() -> void:
	game_core.exit_to_main_menu_requested.connect(_on_exit_to_main_menu)
	game_core.quit_requested.connect(_on_quit)

	main_menu = MAIN_MENU_UID.instantiate()
	main_menu.load_game.connect(load_game)
	add_child(main_menu)

func load_game(savefile: String) -> void:
	game_core.load_game(savefile)
	main_menu.close_menu()

func _on_exit_to_main_menu() -> void:
	get_tree().paused = false
	game_core.unload_game()
	main_menu = MAIN_MENU_UID.instantiate()
	main_menu.load_game.connect(load_game)
	add_child(main_menu)

func _on_quit() -> void:
	get_tree().quit()
