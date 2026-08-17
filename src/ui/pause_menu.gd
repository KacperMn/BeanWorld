extends Control

signal exit_to_main_menu_requested
signal quit_requested

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_ALWAYS
	visible = false

func open_pause_menu() -> void:
	visible = true
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func close_pause_menu() -> void:
	visible = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func toggle_pause() -> void:
	if get_tree().paused:
		close_pause_menu()
	else:
		open_pause_menu()

func _on_continue_game_button_pressed() -> void:
	visible = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _on_back_to_menu_button_pressed() -> void:
	exit_to_main_menu_requested.emit()

func _on_exit_game_button_pressed() -> void:
	quit_requested.emit()