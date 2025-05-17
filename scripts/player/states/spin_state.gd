class_name SpinState
extends State

func enter() -> void:
	state_owner.can_spin = false
	state_owner.spin_cooldown.start()
	state_owner.animated_sprite.play("spin")
	state_owner.spin_stream_player_2d.play()

func physics_update(delta: float) -> void:
	state_owner.destroy_crates()
	
	state_owner.velocity += state_owner.get_gravity() * delta
	
	if state_owner.got_crystal and state_owner.is_on_floor():
		change_state("VictoryState")
		return

	
	if Input.is_action_just_pressed("ui_accept") and state_owner.is_on_floor():
		state_owner.velocity.y = state_owner.JUMP_VELOCITY
		return

	var direction = Input.get_axis("ui_left", "ui_right")
	state_owner.check_direction(direction)

	if direction == 0:
		state_owner.velocity.x = 0  
		return


	state_owner.animated_sprite.flip_h = direction < 0
	state_owner.velocity.x = direction * state_owner.SPEED
