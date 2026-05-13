extends Node

var cane_revealed: bool = false
var radio_revealed: bool = false
var picture_revealed: bool = false
var leash_revealed: bool = false

@onready var sam: AnimationTree = $entities/people/sam/animation_tree
@onready var sam_anim: AnimationPlayer = $entities/people/sam/animation_player
@onready var sam_state: AnimationNodeStateMachinePlayback = sam.get("parameters/playback")
@onready var game: AnimationTree = $animation_tree
@onready var game_anim: AnimationPlayer = $animation_player
@onready var game_state: AnimationNodeStateMachinePlayback = game.get("parameters/playback")

func _ready() -> void:
	$entities/cane.connect("revealed", Callable(self, "cane"))
	$entities/radio.connect("revealed", Callable(self, "radio"))
	$entities/picture.connect("revealed", Callable(self, "picture"))
	$entities/leash.connect("revealed", Callable(self, "leash"))
	
	# lock everything except cane at start
	_lock_all()
	await get_tree().create_timer(1).timeout
	$entities/cane.can_reveal = true
	sam_state.travel("standing_up")

func _lock_all() -> void:
	$entities/cane.can_reveal = false
	$entities/radio.can_reveal = false
	$entities/picture.can_reveal = false
	$entities/leash.can_reveal = false

func cane() -> void:
	cane_revealed = true
	$entities/cane.hide()
	sam_state.travel("cane_idle")
	to_next()

func radio() -> void:
	radio_revealed = true
	sam_state.travel("walking")
	game_state.travel("to_radio")
	# unlock picture called from animation via to_next()

func picture() -> void:
	picture_revealed = true
	sam_state.travel("walking")
	game_state.travel("to_picture")
	# unlock leash called from animation via to_next()

func leash() -> void:
	leash_revealed = true
	sam_state.travel("walking")
	game_state.travel("to_leash")

# called by animation at the END of each sequence
# this is the unlock gate — animation decides when next item is ready
func to_next() -> void:
	if cane_revealed and not radio_revealed:
		$entities/radio.can_reveal = true
		
	elif radio_revealed and not picture_revealed:
		$entities/picture.can_reveal = true
		
	elif picture_revealed and not leash_revealed:
		$entities/leash.can_reveal = true

func to_idle() -> void:
	sam_state.travel("cane_idle")

func outro() -> void:
	$ui/animation_player.play_backwards("fade")
	await $ui/animation_player.animation_finished
	get_tree().change_scene_to_file("res://scenes/game/cutscenes/outro.tscn")
