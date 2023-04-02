extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 5
const mousesens = 0.2 
const sticksens = 2
signal hit(object)
signal hurt()
var health = 40
const knockmod = 0.2
var hurting = 0
var input_dir


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$view/gameovertext.visible = 0
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-deg_to_rad(event.relative.x) * mousesens)
		$view.rotate_x(-deg_to_rad(event.relative.y) * mousesens)
		$view.rotation_degrees.x = clamp($view.rotation_degrees.x, -90, 90)

func _on_area_entered(body):
	if body is CharacterBody3D:
		health -= 10

func knockback(enemy, damage):
	var knockdir = get_node(str(enemy)).position.direction_to(position)
	var knockstrength = damage * knockmod
	var knock = knockdir * knockstrength
	
	

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "forward", "back")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
		
	# controller view control
	var stickdir = Input.get_vector("camleft", "camright", "camup", "camdown")
	rotate_y(-deg_to_rad(stickdir.x)*sticksens)
	$view.rotate_x(-deg_to_rad(stickdir.y)*sticksens)
	$view.rotation_degrees.x = clamp($view.rotation_degrees.x, -90, 90)
	
	if Input.is_action_pressed("escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		
	if Input.is_action_pressed("shoot"):
		if $view/gun/RayCast3D.is_colliding(): 
			emit_signal("hit", $view/gun/RayCast3D.get_collider())
			var t = Timer.new()
			t.set_wait_time(0.2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			await t.timeout
	
	if health < 0:
		health = 0
		
	if health == 0:
		$AnimationPlayer.play("die")
		$view/gameovertext.visible = 1
		var t = Timer.new()
		t.set_wait_time(4)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		await t.timeout
		get_tree().reload_current_scene()
		
	
	move_and_slide()
#	for i in range(get_slide_collision_count()):
#		print(get_slide_collision(i).get_collider(i))
#		if str("spooder") in str(get_slide_collision(i).get_collider(i)):
#			health -= 2
#			knockback("../spooder", 10)
#			var t = Timer.new()
#			t.set_wait_time(2)
#			t.set_one_shot(true)
#			self.add_child(t)
#			t.start()
#			await t.timeout


func _on_area_3d_body_entered(body):
	print(body.name)
	if body.name == "spooder":
		var hurting = 1
		while hurting == 1:
			health -= 10
			print("ouch")
			knockback("../spooder", 10)
			emit_signal("hurt")
			var t = Timer.new()
			t.set_wait_time(2)
			t.set_one_shot(true)
			self.add_child(t)
			t.start()
			await t.timeout


func _on_area_3d_body_exited(body):
	hurting = 0
