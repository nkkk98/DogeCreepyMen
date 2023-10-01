extends CanvasLayer

signal start_game

var prevScore = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func show_notes(text):
	$notes.text = text
	$notes.show()
	$notesTimer.start()

func show_message(text):
	$message.text = text
	$message.show()
	$messageTimer.start()

func show_game_over():
	show_notes("Your heart is broken!")
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $messageTimer.timeout

	$message.text = "Dodge the\nCreeps!"
	$message.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$startButton.show()
	
func update_score(score):
	$scoreLabel.text = str(score)	
	if score > prevScore:
		$scoreLabel.set("theme_override_colors/font_color", Color(0, 1, 0))
	elif score < prevScore:
		$scoreLabel.set("theme_override_colors/font_color", Color(1, 0, 0))
	prevScore = score
		
func _on_start_button_pressed():
	$startButton.hide()
	start_game.emit()

func _on_message_timer_timeout():
	$message.hide()

func _on_notes_timer_timeout():
	$notes.hide()
