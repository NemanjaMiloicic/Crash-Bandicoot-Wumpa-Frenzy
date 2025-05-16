class_name IdleState
extends State

#state_owner is player

func enter() -> void:
	state_owner.animated_sprite.play("idle")

func physics_update(_delta: float) -> void:
	if not state_owner.is_on_floor():
		change_state("JumpState")
		return
		
	if Input.is_action_just_pressed("ui_accept"):
		state_owner.velocity.y = state_owner.JUMP_VELOCITY
		change_state("JumpState")
		return
	
	if Input.is_key_pressed(KEY_CTRL) and state_owner.can_spin:
		change_state("SpinState")
		
	
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction != 0:
		change_state("RunState")
