class_name GridCrate
extends StaticBody2D


@onready var wumpa_stream_player: AudioStreamPlayer2D = $WumpaStreamPlayer
@onready var bounce_stream_player: AudioStreamPlayer2D = $BounceStreamPlayer
@onready var break_stream_player: AudioStreamPlayer2D = $BreakStreamPlayer
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var collision_shape_top_2d: CollisionShape2D = $Top/CollisionShape2D
@onready var collision_shape_bottom_2d: CollisionShape2D = $Bottom/CollisionShape2D


var first_hit = true
var number_of_hits = 5
var broken = false

func _on_area_2d_body_entered(body: Node2D) -> void:
	crate_hit(body, true)
					


func _on_bottom_body_entered(body: Node2D) -> void:
	crate_hit(body, false)


func crate_hit(body:Node2D , top : bool) -> void:
	
	if body is CharacterBody2D and body.current_state is not SpinState and body.current_state is not BellyFlopState and not broken:
			if number_of_hits>0:
				animation_player.play("expand")
				if first_hit:
					timer.start()
					first_hit = false
				bounce_stream_player.play()
				wumpa_stream_player.play()
				if top and body.current_state is not SpinState:
					body.velocity.y = body.JUMP_VELOCITY - 40  
				number_of_hits -= 1
				if number_of_hits ==0:
					broken = true
					break_stream_player.play()
					sprite_2d.visible = false
					collision_shape_2d.set_deferred("disabled", true)
					await break_stream_player.finished
					queue_free()
	

func _on_timer_timeout() -> void:
	if not broken:
		number_of_hits = 1


func _on_crate_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.near_crates.append(self)

func _on_crate_body_exited(body: Node2D) -> void:
	if body is CharacterBody2D:
		body.near_crates.erase(self)

func destroy() -> void:
	broken = true
	collision_shape_2d.set_deferred("disabled", true)
	collision_shape_top_2d.set_deferred("disabled", true)
	collision_shape_top_2d.set_deferred("disabled", true)
	break_stream_player.play()
	sprite_2d.visible = false
	await break_stream_player.finished
	queue_free()


	
