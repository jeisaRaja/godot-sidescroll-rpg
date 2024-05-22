extends CharacterBody2D
class_name Actor

const SPEED = 300.0
const JUMP_VELOCITY = -300.0

@onready var ray = $RayCast2D
@onready var FMS = $FMS
@onready var Anim = $AnimationPlayer

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var facingDir: Vector2 = Vector2(1,1)
var busy: bool = false
var canDoubleJump: bool = false

# Player Input
var movement_input = Vector2.ZERO
var jump_input = false
var jump_input_actuation = false
var climb_input = false
var dash_input = false

# Mechanics
var can_dash: bool = true
var dash_cooldown: float = 2

func _ready():
	for state in FMS.get_children():
		state.Actor = self
		state.FMS = FMS
		state.Anim = Anim
	FMS.initiate_states_machine()
	
func _physics_process(delta):
	player_input()
	apply_gravity(delta)
	move_and_slide()
	
func apply_gravity(delta: float):
	if not is_on_floor():
		velocity.y += gravity * delta
		
func handle_jump():
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		canDoubleJump = true
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_just_pressed("ui_accept") and !is_on_floor() and canDoubleJump:
		canDoubleJump = false
		velocity.y = JUMP_VELOCITY

func handle_wall_jump():
	if not is_on_wall_only(): return
	var wall_normal = get_wall_normal()
	if Input.is_action_just_pressed("ui_accept") and wall_normal == Vector2.RIGHT:
		velocity.x = wall_normal.x * SPEED * 2
		velocity.y = JUMP_VELOCITY

func player_input():
	movement_input = Vector2.ZERO
	if Input.is_action_pressed("MoveRight"):
		movement_input.x += 1
	if Input.is_action_pressed("MoveLeft"):
		movement_input.x -= 1
	if Input.is_action_pressed("MoveUp"):
		movement_input.y -= 1
	if Input.is_action_pressed("MoveDown"):
		movement_input.y += 1
	
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

func _on_dash_cooldown_timeout():
	can_dash = true
