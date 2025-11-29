extends Node

var squad: Array[CharacterBody2D] = []
var current_leader_index: int = 0

func _ready() -> void:
	# Wait a frame to ensure all nodes are ready
	await get_tree().process_frame
	
	# Find all players in the "player" group
	# In a real scenario, you might spawn them or register them explicitly
	var players = get_tree().get_nodes_in_group("player")
	for p in players:
		if p is CharacterBody2D:
			squad.append(p)
	
	if squad.size() > 0:
		set_leader(0)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_focus_next"): # Tab or something, but let's use numbers
		pass
		
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_1:
			set_leader(0)
		elif event.keycode == KEY_2:
			set_leader(1)
		elif event.keycode == KEY_3:
			set_leader(2)

func set_leader(index: int) -> void:
	if index < 0 or index >= squad.size():
		return
	
	current_leader_index = index
	
	for i in range(squad.size()):
		var member = squad[i]
		if i == current_leader_index:
			member.is_leader = true
			member.target_to_follow = null
			# Update Camera
			CameraSystem.set_target(member)
		else:
			member.is_leader = false
			member.target_to_follow = squad[current_leader_index]
