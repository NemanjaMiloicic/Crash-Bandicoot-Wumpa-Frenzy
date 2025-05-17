class_name IdleState
extends State


func enter() -> void:
	if state_owner.previous_state is SlideState:
		state_owner.velocity.x = 0
		state_owner.velocity.y = 0
		state_owner.move_and_slide()
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
		state_owner.check_direction(direction)
		change_state("RunState")
