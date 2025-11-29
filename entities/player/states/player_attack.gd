class_name PlayerAttack
extends State

var player: Player

func enter(_msg := {}) -> void:
	player = entity as Player
	player.animation_player.play("attack")
	
	# 初始化冲刺方向和速度
	var direction = Vector2.RIGHT if not player.sprite.flip_h else Vector2.LEFT
	player.velocity_component.velocity = direction * 300.0 # 提高一点数值让冲刺更明显

# 修复：物理逻辑必须每帧更新，不能写在 enter 里等 await
func physics_update(delta: float) -> void:
	# 持续施加摩擦力/减速
	player.velocity_component.decelerate(delta)
	# 持续应用移动，防止“卡帧”
	player.velocity_component.move(player)
	
	# 检查动画是否结束来切换状态
	if not player.animation_player.is_playing() or player.animation_player.current_animation != "attack":
		state_machine.transition_to("Idle")