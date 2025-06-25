extends CharacterBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox_area: Area2D = $HitboxArea
@onready var enemy_area: Area2D = $EnemyArea
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var hitbox_shape_2d: CollisionShape2D = $HitboxArea/CollisionShape2D
@onready var death_timer: Timer = $DeathTimer
@onready var spin_death_sound: AudioStreamPlayer = $SpinDeathSound
@onready var bounce_death_sound: AudioStreamPlayer = $BounceDeathSound
@onready var bat_screech_sound: AudioStreamPlayer = $BatScreechSound


var states = {}
var current_state : State
var previous_state : State

var direction := 1 
var player
var is_dead := false
var knockback_direction = 1
var spun := false
var alerted := false
const BOUNCE := 60
const KNOCKBACK := 400
const JUMP_FORCE := -250
const SPEED := 50

func _ready() -> void:
	states["SleepingState"] = SleepingBatState.new(self)
	states["ChasingState"] = ChasingBatState.new(self)

	current_state = states["SleepingState"]
	current_state.enter()

func _physics_process(delta):
	EnemyHelper.death(self)
	if current_state:
		current_state.physics_update(delta)
	move_and_slide()


func _on_enemy_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player = body
		alerted = true


func _on_death_timer_timeout() -> void:
	queue_free()


func _on_head_area_body_entered(body: Node2D) -> void:
	EnemyHelper.bounce(self , body)
