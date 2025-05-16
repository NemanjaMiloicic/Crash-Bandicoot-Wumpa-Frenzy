class_name RunState
extends State

func enter() -> void:
	state_owner.animated_sprite.play("run")

func physics_update(_delta: float) -> void:
	
	if state_owner.got_crystal and state_owner.is_on_floor():
		change_state("VictoryState")
		return
	
	if not state_owner.is_on_floor():
		change_state("JumpState")
		return
	
	if Input.is_action_just_pressed("ui_accept"):
		state_owner.velocity.y = state_owner.JUMP_VELOCITY
		change_state("JumpState")
		return
	
	if Input.is_key_pressed(KEY_CTRL) and state_owner.can_spin:
		change_state("SpinState")
		return

	var direction = Input.get_axis("ui_left", "ui_right")

	if direction == 0:
		state_owner.velocity.x = 0  
		change_state("IdleState")
		return


	state_owner.animated_sprite.flip_h = direction < 0
	state_owner.velocity.x = direction * state_owner.SPEED
