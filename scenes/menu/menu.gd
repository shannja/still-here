extends Node

var pressed_play_flag: bool = false

func _ready() -> void:
	if Configurations.is_finished:
		$background/hero.play("dead")
	else:
		$background/hero.play("alive")

func _on_affection_pressed() -> void:
	if not Configurations.is_finished:
		$background/hero.play("affection")
		await $background/hero.animation_finished
		$background/hero.play("alive")

func _on_play_pressed() -> void:
	if pressed_play_flag != true:
		pressed_play_flag = true
		
		$animation_player.play("next_scene")
		await $animation_player.animation_finished
		get_tree().change_scene_to_file("res://scenes/game/cutscenes/intro.tscn")

func _on_info_pressed() -> void:
	OS.shell_open("https://drive.google.com/drive/folders/1oxd57H6BnhfWNdmnAcyrZGCbp5Zr2u0E?usp=sharing")
