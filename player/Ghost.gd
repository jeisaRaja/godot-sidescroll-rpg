extends Sprite2D
class_name Ghost

func _ready():
	ghosting()
	
func set_property(tx_post, flip):
	position = tx_post - Vector2(0,40)
	flip_h = flip
	
func ghosting():
	var tween_fade = get_tree().create_tween()
	tween_fade.tween_property(self, "self_modulate", Color(1, 1, 1, 0), 0.75)
	await tween_fade.finished
	
	queue_free()
