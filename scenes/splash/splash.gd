extends Node

func _on_animation_tree_animation_finished(anim_name: StringName) -> void:
	# animation_tree name and animation_player name must be same.
	if anim_name == "logo_splash": 
		get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")
