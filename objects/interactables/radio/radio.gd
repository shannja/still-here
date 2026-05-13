extends Interactable

var barked: bool = false
var player: Player = null
func _physics_process(_delta: float) -> void:
	if player:
		if player.is_barking and not barked:
			barked = true
			reveal()
			print("ho")

func _on_body_entered(body: Player) -> void:
	player = body

func _on_body_exited(_body: Player) -> void:
	player =  null
