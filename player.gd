extends Area2D 
signal hit

@export var speed = 400 # How fast the player will move (pixels/sec).
@export var shoot_scene:PackedScene
var can_spawn = true
var screen_size # Size of the game window.
func _ready():
	#hide()
	screen_size = get_viewport_rect().size
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
	#if Input.is_action_pressed("shoot"):
		#if can_spawn==true:
			#var new_shoot = shoot_scene.instantiate()
			#new_shoot.position = self.position
			#add_child(new_shoot)
			#can_spawn=false

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	if velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		# See the note below about the following boolean assignment.
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
func _on_body_entered(_body):
	if _body.is_in_group("mobs"):
		hide() # Player disappears after being hit.
		hit.emit()
		print(_body.name)
	# Must be deferred as we can't change physics properties on a physics callback.
		$CollisionShape2D.set_deferred("disabled", true)
func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on__shoot_timeout():
	can_spawn=true # Replace with function body.
	print("update")
