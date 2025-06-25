class_name EnemyHelper
extends Node

static func death(enemy : Node2D) -> void:
	if enemy.is_dead:
		if enemy.spun:
			enemy.velocity.x += enemy.knockback_direction * enemy.KNOCKBACK 
			enemy.move_and_slide()
			return
		else:
			enemy.animated_sprite_2d.visible = false  

static func bounce(enemy : Node2D , body : Node2D) -> void:
	if enemy.is_dead:
		return

	if not body.is_in_group("player"):
		return
	
	
	if body.current_state is BellyFlopState:
		die_by_bounce(enemy)
		enemy.is_dead = true
	elif body.current_state is JumpState:
		if body.slid_jumped:
			body.velocity.y = body.JUMP_VELOCITY 
		else:
			body.velocity.y = body.JUMP_VELOCITY - enemy.BOUNCE
		die_by_bounce(enemy)
		enemy.is_dead = true



static func die(enemy : Node2D ) -> void:
	enemy.is_dead = true
	enemy.current_state.exit()
	enemy.animated_sprite_2d.play("death")
	enemy.collision_shape_2d.set_deferred("disabled" , true)
	enemy.death_timer.start()

static func die_by_bounce(enemy : Node2D) -> void:
	enemy.bounce_death_sound.play()
	EnemyHelper.die(enemy)

static func die_by_hit(enemy : Node2D , body : Node2D) -> void:
	enemy.spin_death_sound.play()
	enemy.knockback_direction = body.facing_right
	EnemyHelper.die(enemy)
