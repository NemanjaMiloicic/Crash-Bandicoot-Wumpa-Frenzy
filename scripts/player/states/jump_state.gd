class_name JumpState
extends State

const SLIDE_JUMP_BOOST = -4

func enter() -> void:
	if state_owner.previous_state is SlideState:
		state_owner.previous_state.exit()
		state_owner.animated_sprite.play("slide_jump")
	else:
		state_owner.animated_sprite.play("jump")

func physics_update(delta: float) -> void:
	if Input.is_key_pressed(KEY_CTRL) and state_owner.can_spin:
		change_state("SpinState")

	if state_owner.got_crystal and state_owner.is_on_floor():
		change_state("VictoryState")
		return

	# Gravity
	if state_owner.previous_state is SlideState:
		state_owner.velocity += state_owner.get_gravity() * delta + Vector2(0,SLIDE_JUMP_BOOST)
	else:
		state_owner.velocity += state_owner.get_gravity() * delta
	

	# Input & movement
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		state_owner.animated_sprite.flip_h = direction < 0
		state_owner.velocity.x = direction * state_owner.SPEED
	else:
		state_owner.velocity.x = move_toward(state_owner.velocity.x, 0, state_owner.SPEED)
	
	if state_owner.previous_state is not SlideState and Input.is_key_pressed(KEY_SHIFT) and state_owner.velocity.y <= 0:
		change_state("BellyFlopState")
	
	# Landed on ground
	if state_owner.is_on_floor():
		if direction == 0:
			change_state("IdleState")
		else:
			state_owner.check_direction(direction)
			change_state("RunState")
