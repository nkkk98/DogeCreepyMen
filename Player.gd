extends Area2D
signal hit
signal costumeHit
signal costumeHurt

@export var speed = 400
var screen_size
var hited = false

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	
	if hited == false:
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
			$AnimatedSprite2D.play()
		else:
			$AnimatedSprite2D.stop()
	else:
		velocity = Vector2.ZERO 		
		$AnimatedSprite2D.play()
		
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	
	if hited == true:
		$AnimatedSprite2D.animation = "damage"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = false
		hited = false
	elif velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0


func _on_body_entered(body):
	if body.type == body.costumeType:
		if body.realType != body.type:
			hited = true
			costumeHurt.emit()
		else:
			costumeHit.emit()
	else :
		hited = true
		hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	#$CollisionShape2D.set_deferred("disabled", true)

func start(pos):
	position = pos
	$AnimatedSprite2D.animation = "walk"
	show()
	$CollisionShape2D.disabled = false
