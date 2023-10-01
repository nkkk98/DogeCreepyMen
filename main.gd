extends Node

@export var mob_scene: PackedScene
var score

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func hurted_by_man():
	$HUD.show_notes("Hurted by a creepy man...")
	score -= 4
	
	if score < 0:
		score = 0
		$HUD.update_score(score)
		game_over()
	else:
		$HUD.update_score(score)


func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	
func new_game():
	get_tree().call_group("mobs", "queue_free")
	$Player.start($StartPosition.position)
	$StartTimer.start()
	score = 0
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")

func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)

func _on_mob_timer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instantiate()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobFollowPath")
	mob_spawn_location.progress_ratio = randf()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += randf_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)

func hurted_by_a_costumed_man():
	$HUD.show_notes("Is this purple guy a good man? Get more serious damage!")
	score -= 6
	
	if score < 0:
		score = 0
		$HUD.update_score(score)
		game_over()
	else:
		$HUD.update_score(score)
	
func meet_with_a_purple_guy():
	$HUD.show_notes("Is this purple guy a good man? Wow, he is a good guy.")
	score += 10
	$HUD.update_score(score)
