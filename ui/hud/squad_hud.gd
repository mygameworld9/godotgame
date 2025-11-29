extends CanvasLayer

var status_scene = preload("res://ui/hud/character_status.tscn")
@onready var container = $HBoxContainer

func _ready() -> void:
	# Wait for SquadManager to be ready
	await get_tree().process_frame
	await get_tree().process_frame
	
	for member in SquadManager.squad:
		var status = status_scene.instantiate()
		container.add_child(status)
		status.setup(member)
