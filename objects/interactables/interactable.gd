class_name Interactable
extends Area2D

signal revealed

var is_revealed: bool = false

func reveal() -> void:
	if is_revealed:
		return
	is_revealed = true
	_transform(0.6)

func _transform(duration: float) -> void:
	var tween: Tween = create_tween()
	tween.tween_method(
		func(value: float): get_node("texture").material.set_shader_parameter("progress", value),
		0.0,
		1.0,
		duration
	)
	tween.tween_callback(func(): _on_revealed())

func _on_revealed() -> void:
	# signal up to Sam's state machine
	revealed.emit()
