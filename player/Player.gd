extends CharacterBody2D
class_name ActorClass

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

@export var ghost_node: PackedScene
@onready var FMS = $FMS
@onready var Anim = $AnimationPlayer
@onready var coyote_timer = $Timer/Coyote
@onready var sprite = $SpriteParent
@onready var sword_hitbox = $Sword

# Raycast
@onready var top_ray = $Raycast/Top
@onready var bot_ray = $Raycast/Bottom

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var facing_dir: int = 1
# Test var
@onready var label = $Label

# Player Input
var movement_input = Vector2.ZERO
var jump_input: bool = false
var jump_input_actuation: bool = false
var climb_input: bool = false
var dash_input: bool = false
var attack_input: bool = false

# Mechanics
var can_dash: bool = true
var can_coyote: bool = false
var was_on_floor: bool = true
var is_jumping: bool = false
var dash_cooldown: float = 1
var jump_count: int = 0
var max_jump_count: int = 2

func _ready():
	for state in FMS.get_children():
		state.Actor = self
		state.Anim = Anim
		state.FMS = FMS
		state.ActorSprite = sprite
	FMS.initiate_states_machine()
	
func _process(delta):
	label.text = FMS.get_current_state_name()
	
func _physics_process(delta):
	player_input()
	was_on_floor = is_on_floor()
	move_and_slide()
	check_coyote()
	
func check_coyote():
	if was_on_floor and !is_on_floor():
		coyote_timer.start()
	if not coyote_timer.is_stopped():
		can_coyote = true
	else:
		can_coyote = false
	
	
func apply_gravity(delta: float):
	if not is_on_floor():
		velocity.y += gravity * delta

func player_input():
	movement_input = Vector2.ZERO
	if Input.is_action_pressed("MoveRight"):
		movement_input.x = 1
	if Input.is_action_pressed("MoveLeft"):
		movement_input.x = -1
	if Input.is_action_pressed("MoveUp"):
		movement_input.y = -1
	if Input.is_action_pressed("MoveDown"):
		movement_input.y = 1
	if Input.is_action_pressed("Jump"):
		jump_input = true
	else:
		jump_input = false
	
	if Input.is_action_just_pressed("Jump"):
		jump_input_actuation = true
	else:
		jump_input_actuation = false
	
	if Input.is_action_just_pressed("Dash"):
		dash_input = true
	else:
		dash_input = false
	
	if Input.is_action_just_pressed("Attack"):
		attack_input = true
	else:
		attack_input = false
		
func is_next_to_wall():
	var allColliding: bool = true
	top_ray.force_raycast_update()
	bot_ray.force_raycast_update()
	if not top_ray.is_colliding() or not bot_ray.is_colliding():
		allColliding = false
	return allColliding

func is_player_hanging():
	return top_ray.is_colliding() and not bot_ray.is_colliding()

func _on_dash_cooldown_timeout():
	can_dash = true

func add_ghost():
	var ghost = ghost_node.instantiate()
	ghost.set_property(position, sprite.scale)
	get_tree().current_scene.add_child(ghost)

func flip_hitbox(dir: int):
	sword_hitbox.scale.x = dir
	
func flip_raycast(dir: int):
	top_ray.scale.x = dir
	bot_ray.scale.x = dir
