class_name HitGroundState
extends State

func enter() -> void:
	state_owner.animated_sprite.play("hit_ground")
	state_owner.hit_ground_stream_player_2d.play()
	state_owner.collision_shape_2d.shape.height -= state_owner.slide_height_reduction

func exit() -> void:
		state_owner.collision_shape_2d.shape.height += state_owner.slide_height_reduction

func physics_update(_delta: float) -> void:
	if state_owner.got_crystal:
		state_owner.collision_shape_2d.shape.height += state_owner.slide_height_reduction
		change_state("VictoryState")
