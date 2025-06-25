class_name WanderingFrogState
extends State

var jump_counter := 0
var max_jumps_in_direction := 2
var should_turn := false


func physics_update(delta: float) -> void:
	state_owner.velocity += state_owner.get_gravity() * delta

	if state_owner.is_on_floor():
		if should_turn:
			state_owner.direction *= -1
			state_owner.animated_sprite_2d.flip_h = state_owner.direction < 0
			should_turn = false

		if state_owner.can_move and state_owner.can_jump:
			state_owner.ribbit_sound.play()
			state_owner.velocity.x = state_owner.direction * state_owner.SPEED
			state_owner.can_jump = false
			jump_counter += 1

			if jump_counter >= max_jumps_in_direction:
				jump_counter = 0
				should_turn = true

	if state_owner.is_on_floor() and not state_owner.is_jumping and state_owner.animated_sprite_2d.animation != "stand":
		state_owner.velocity = Vector2.ZERO
		state_owner.animated_sprite_2d.play("stand")
