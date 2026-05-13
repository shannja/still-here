extends Node

func to_menu() -> void:
	Configurations.is_finished = true
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
