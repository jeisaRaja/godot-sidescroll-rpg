extends Node
class_name State

signal Transitioned(state, newStateName)

var Actor: ActorClass = null
var ActorSprite: Node2D = null
var Anim: AnimationPlayer = null
var FMS = null

func Enter():
	pass
	
func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	pass

func actor_movement():
	if Actor.movement_input.x > 0:
		Actor.velocity = Actor.velocity.move_toward(Vector2(Actor.SPEED, Actor.velocity.y), 50)
		ActorSprite.scale.x = 1
		flip_raycast(1)
		Actor.flip_hitbox(1)
		Actor.facing_dir = 1
	elif Actor.movement_input.x < 0:
		Actor.velocity = Actor.velocity.move_toward(Vector2(-Actor.SPEED, Actor.velocity.y), 50)		
		ActorSprite.scale.x = -1
		flip_raycast(-1)
		Actor.flip_hitbox(-1)
		Actor.facing_dir = -1
	else:
		Actor.velocity.x = 0
	
func flip_raycast(dir: int):
	for raycast in Actor.Raycast.get_children():
		if raycast is RayCast2D:
			raycast.scale.x = dir
			raycast.force_raycast_update()

