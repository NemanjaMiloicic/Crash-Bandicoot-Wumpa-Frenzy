extends CharacterBody2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var victory_stream_player_2d: AudioStreamPlayer2D = $VictoryStreamPlayer2D
@onready var spin_stream_player_2d: AudioStreamPlayer2D = $SpinStreamPlayer2D
@onready var spin_cooldown: Timer = $SpinCooldown
@onready var slide_cooldown: Timer = $SlideCooldown
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D
@onready var hit_ground_stream_player_2d: AudioStreamPlayer2D = $HitGroundStreamPlayer2D


var got_crystal = false 
var can_spin = true
var can_slide = true
var near_crates = []
var facing_right = 1
var slide_height_reduction = 10

var current_state : State = null
var previous_state : State = null
var states = {}

func _ready() -> void:
	states["IdleState"] = IdleState.new()
	states["RunState"] = RunState.new()
	states["JumpState"] = JumpState.new()
	states["DeadState"] = DeadState.new()
	states["VictoryState"] = VictoryState.new()
	states["SpinState"] = SpinState.new()
	states["SlideState"] = SlideState.new()
	states["BellyFlopState"] = BellyFlopState.new()
	states["HitGroundState"] = HitGroundState.new()
	for state in states.values():
		state.state_owner = self
	
	current_state = states["IdleState"]
	current_state.enter()

func _physics_process(delta: float) -> void:
	
	if current_state:
		current_state.physics_update(delta)
		
	# Move the character after velocity is updated in the state
	move_and_slide()


func _on_animated_sprite_2d_animation_finished() -> void:
	if animated_sprite.animation == "victory_dance" or animated_sprite.animation == "spin":
		current_state.change_state("IdleState")
	if animated_sprite.animation == "slide" :
		current_state.exit()
		current_state.change_state("IdleState")
	
	if animated_sprite.animation == "hit_ground":
		current_state.exit()
		current_state.change_state("IdleState")
	
	
	


func _on_spin_cooldown_timeout() -> void:
	can_spin = true

func check_direction(direction):
		if direction == 1:
			facing_right = 1 
		else:
			facing_right = -1 


func _on_slide_cooldown_timeout() -> void:
	can_slide = true
	
func destroy_crates() -> void:
	if near_crates.size()>0:
		for crate in near_crates:
			crate.destroy()
		near_crates.clear()
