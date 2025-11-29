extends Node

var camera: Camera2D
var target: Node2D

func _ready() -> void:
	pass

func register_camera(cam: Camera2D) -> void:
	camera = cam
	# If we have a target waiting, snap to it or start following
	if target:
		camera.global_position = target.global_position

func set_target(new_target: Node2D) -> void:
	target = new_target

func _process(delta: float) -> void:
	if not camera or not target:
		return
		
	# Smooth follow
	camera.global_position = camera.global_position.lerp(target.global_position, 5.0 * delta)
