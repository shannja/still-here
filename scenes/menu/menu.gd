extends Node

var pressed_play_flag: bool = false

func _on_affection_pressed() -> void:
	$background/hero.play("affection")
	await $background/hero.animation_finished
	$background/hero.play("alive")

func _on_play_pressed() -> void:
	if pressed_play_flag != true:
		pressed_play_flag = true
		
		$animation_player.play("next_scene")
		await $animation_player.animation_finished
		get_tree().change_scene_to_file("res://scenes/game/cutscenes/intro.tscn")
