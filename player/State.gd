extends Node
class_name PlayerState
@export var player: CharacterBody2D
signal Transitioned(state, newStateName)

static func isAttack():
	var isAttack: bool = Input.is_action_just_pressed("attack")
	return isAttack

func Enter():
	pass
	
func Exit():
	pass

func Update(_delta: float):
	pass

func Physics_Update(_delta: float):
	if(isAttack()):
		Transitioned.emit(self, "PlayerAttack")
	if player.velocity.x != 0:
		Transitioned.emit(self,"PlayerWalk")
	if player.velocity.y <0:
		Transitioned.emit(self,"PlayerJump")
