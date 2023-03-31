extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 7.5
const mousesens = 0.2 
const sticksens = 2

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-deg_to_rad(event.relative.x) * mousesens)
		$view.rotate_x(-deg_to_rad(event.relative.y) * mousesens)
		$view.rotation_degrees.x = clamp($view.rotation_degrees.x, -90, 90)
	
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

	move_and_slide()
