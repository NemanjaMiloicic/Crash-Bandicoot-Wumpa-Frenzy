class_name ChasingBatState
extends State


func enter() -> void:
	state_owner.bat_screech_sound.play()
	state_owner.animated_sprite_2d.play("flying")

func physics_update(_delta: float) -> void:
	if not state_owner.alerted:
		return
	if state_owner.is_dead:
		return
	if state_owner.player.current_state is DeadState:
		state_owner.velocity = Vector2.ZERO
		return
	
	var bat_position = state_owner.global_position
	var player_position = state_owner.player.global_position

	var direction = (player_position - bat_position).normalized()
	state_owner.velocity = direction * state_owner.SPEED
	
	state_owner.animated_sprite_2d.flip_h = direction.x < 0
