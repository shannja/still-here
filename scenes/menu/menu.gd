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
	OS.shell_open("https://docs.google.com/document/d/1jpQr9uMytjZvuMWd_O_TgjggPy6phpP13-Ajt2dYVhc/edit?usp=sharing")

func _on_sound_pressed() -> void:
	pass # Replace with function body.
