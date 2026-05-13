class_name Interactable
extends Area2D

signal revealed

var is_revealed: bool = false
var can_reveal: bool = false
var barked: bool = false
var _tween: Tween

func reveal() -> void:
	if is_revealed:
		return
	if not can_reveal:
		_reject()
		barked = false  # reset here in parent
		return
	is_revealed = true
	_transform(0.6)

func _reject() -> void:
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_method(
		func(value: float): get_node("texture").material.set_shader_parameter("progress", value),
		0.0,
		0.4,
		0.3
	)
	_tween.tween_method(
		func(value: float): get_node("texture").material.set_shader_parameter("progress", value),
		0.4,
		0.0,
		0.2
	)

func _transform(duration: float) -> void:
	if _tween:
		_tween.kill()
	_tween = create_tween()
	_tween.tween_method(
		func(value: float): get_node("texture").material.set_shader_parameter("progress", value),
		0.0,
		1.0,
		duration
	)
	_tween.tween_callback(func(): _on_revealed())

func _on_revealed() -> void:
	revealed.emit()
