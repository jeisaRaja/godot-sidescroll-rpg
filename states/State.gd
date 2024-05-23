extends Node
class_name State

signal Transitioned(state, newStateName)

var Actor: ActorClass = null
var ActorSprite: Sprite2D = null
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
		Actor.velocity.x = Actor.SPEED
		ActorSprite.flip_h = false
	elif Actor.movement_input.x < 0:
		Actor.velocity.x = - Actor.SPEED
		ActorSprite.flip_h = true
	else:
		Actor.velocity.x = 0
	
