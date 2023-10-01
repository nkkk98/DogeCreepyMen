extends RigidBody2D

var type
var realType
var costumeType = "walkCostume"
# Called when the node enters the scene tree for the first time.
func _ready():
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	type =  mob_types[randi() % mob_types.size()]
	realType = type
	if type == costumeType and randi() % 10 > 0:
		realType = "walk"
	$AnimatedSprite2D.play(type)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
