extends Node

func _on_affection_pressed() -> void:
	$background/hero.play("affection")
	await $background/hero.animation_finished
	$background/hero.play("alive")
