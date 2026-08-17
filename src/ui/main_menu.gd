extends Control

signal load_game(savefile: String)

var current_screen: String

@onready var screens: Dictionary[String, Control] = {
	"title_screen" = $TitleScreen,
	"loading_screen" = $LoadingScreen,
	"settings_screen" = $SettingsScreen
}

func _ready() -> void:
	set_current_screen("title_screen")

func _on_new_game_button_pressed() -> void:
	set_current_screen("loading_screen")
	load_game.emit("")

func _on_load_game_button_pressed() -> void:
	# swap to settings savefile choice screen
	pass # Replace with function body.


func _on_options_button_pressed() -> void:
	# swap to settings savefile choice screen
	pass # Replace with function body.

func close_menu() -> void:
	queue_free()

func set_current_screen(screen_name: String) -> void:
	if not screens.has(screen_name):
		push_error("No screen found with the name " + screen_name)
		return
	current_screen = screen_name
	for screen in screens:
		screens[screen].visible = (screen == screen_name)
