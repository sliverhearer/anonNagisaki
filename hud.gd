extends CanvasLayer
signal start_game
func show_message(text):
	$Message.text = text
	$Message.show()
	$Help.show()
	$Soyo.show()
	$MessageTimer.start()
func show_game_over():
	show_message("Game Over")
	# Wait until the MessageTimer has counted down.
	await $MessageTimer.timeout

	$Message.text = "Bang Dream \n It's mygo !!!!!"
	$Help.text="WASD控制移动 \n \n 躲这个→"
	$Message.show()
	$Help.show()
	$Soyo.show()
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1.0).timeout
	$StartButton.show()
func update_score(score):
	$ScoreLabel.text = str(score)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit() # Replace with function body.


func _on_message_timer_timeout():
	$Soyo.hide()
	$Help.hide()
	$Message.hide() # Replace with function body.
