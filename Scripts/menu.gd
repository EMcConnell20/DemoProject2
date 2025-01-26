extends Control

## Funcs ##

func _on_play_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main.tscn")


func _on_options_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/options.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
