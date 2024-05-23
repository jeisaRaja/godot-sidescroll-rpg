extends CharacterBody2D
class_name ActorClass

const SPEED = 200.0
const JUMP_VELOCITY = -300.0

@onready var Raycast = $Raycast
@export var ghost_node: PackedScene
@onready var FMS = $FMS
@onready var Anim = $AnimationPlayer
@onready var coyote_timer = $Timer/Coyote
@onready var ghost_timer = $Timer/GhostTimer
@onready var sprite = $Sprite2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var facingDir: Vector2 = Vector2(1,1)

# Player Input
var movement_input = Vector2.ZERO
var jump_input = false
var jump_input_actuation = false
var climb_input = false
var dash_input = false
var attack_input = false

# Mechanics
var can_dash: bool = true
var dash_cooldown: float = 2
var was_on_floor: bool = true
var can_coyote: bool = false

func _ready():
	for state in FMS.get_children():
		state.Actor = self
		state.Anim = Anim
		state.FMS = FMS
		state.ActorSprite = sprite
	FMS.initiate_states_machine()
	
func _physics_process(delta):
	player_input()
	apply_gravity(delta)
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
	for raycast in Raycast.get_children():
		if raycast is RayCast2D:
			raycast.force_raycast_update()
			if not raycast.is_colliding():
				allColliding = false
			else:
				print(raycast.get_collider())
	return allColliding
				
func _on_dash_cooldown_timeout():
	can_dash = true

func add_ghost():
	var ghost = ghost_node.instantiate()
	ghost.set_property(position, sprite.flip_h)
	get_tree().current_scene.add_child(ghost)
