extends Control

signal back_to_game
signal exit_to_main
signal quit

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS

func _on_continue_game_button_pressed() -> void:
	back_to_game.emit()

func _on_back_to_menu_button_pressed() -> void:
	exit_to_main.emit()

func _on_exit_game_button_pressed() -> void:
	quit.emit()