extends Node

func _ready() -> void:
	# Connect to the interactables.
	$entities/cane.connect("revealed", Callable(self, "cane"))
	$entities/radio.connect("revealed", Callable(self, "radio"))
	$entities/picture.connect("revealed", Callable(self, "picture"))
	$entities/leash.connect("revealed", Callable(self, "leash"))
	
	await get_tree().create_timer(1).timeout
	sam_state.travel("standing_up")

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

func update_game_state() -> void:
	if cane_revealed:
		$entities/cane.hide()
		sam_state.travel("cane_idle")
		
	if cane_revealed and radio_revealed:
		sam_state.travel("walking")
		game_state.travel("to_radio")
		# to_idle() call from animation.
	
	if cane_revealed and radio_revealed and picture_revealed:
		sam_state.travel("walking")
		game_state.travel("to_picture")
		# to_idle() call from animation.
	
	if cane_revealed and radio_revealed and picture_revealed and leash_revealed:
		sam_state.travel("walking")
		game_state.travel("to_leash")
		# to_idle() call from animation.

func cane() -> void:
	cane_revealed = true
	update_game_state()

func radio() -> void:
	radio_revealed = true
	update_game_state()

func picture() -> void:
	picture_revealed = true
	update_game_state()

func leash() -> void:
	leash_revealed = true
	update_game_state()


func to_idle() -> void:
	sam_state.travel("cane_idle")
