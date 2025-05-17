class_name SlideState
extends State



func enter() -> void:
	state_owner.animated_sprite.play("slide")
	state_owner.slide_cooldown.start()
	state_owner.can_slide = false
	state_owner.collision_shape_2d.shape.height -= state_owner.slide_height_reduction
	
func physics_update(_delta: float) -> void:
	state_owner.destroy_crates()
	
	if Input.is_action_just_pressed("ui_accept"):
		state_owner.velocity.y = state_owner.JUMP_VELOCITY
		change_state("JumpState")
		return

	state_owner.velocity.x =  state_owner.facing_right*state_owner.SPEED*1.25

func exit() -> void:
		state_owner.collision_shape_2d.shape.height += state_owner.slide_height_reduction
		
