extends State

var player: Player

func enter(_msg := {}) -> void:
	player = entity as Player
	player.velocity_component.velocity = Vector2.ZERO
	player.animation_player.play("death")
	# Disable collision with enemies/projectiles? 
	# Maybe change collision layer/mask, but for now just stay put.
	# We want to keep collision so we can be found/revived, 
	# but maybe ignore enemy attacks?
	
	# Optional: Emit signal that we are downed
	# Events.emit_signal("player_downed", player)

func exit() -> void:
	# Reset anything if needed when revived
	player.animation_player.play("idle") # Reset to idle or similar

func physics_update(delta: float) -> void:
	# Do nothing, we are down.
	pass
