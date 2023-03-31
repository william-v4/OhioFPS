extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5
const mousesens = 0.2
const cameraanglev = 0
var caminput : Vector2
var rotationv : Vector2
const smoothness = 10

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity= ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _input(event):
	if event is InputEventMouseMotion:
		caminput = event.relative


func _physics_process(delta):
	rotationv = rotationv.lerp(caminput * mousesens, delta * smoothness)
	rotate_x(clamp(deg_to_rad(caminput.y), -180, 180))t
	rotate_y(clamp(deg_to_rad(caminput.x), -90, 90))
	#rotation_degrees.x = clamp(rotation_degrees.x, -90, 90)
	#rotation_degrees.y = clamp(rotation_degrees.y, -180, 180)
	caminput = Vector2.ZERO
	if Input.is_action_pressed("escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
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

	move_and_slide()
