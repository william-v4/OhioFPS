extends Camera3D

const mousesens = 0.2
const cameraanglev = 0
var caminput : Vector2
var rotationv : Vector2
const smoothness = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event):
	if event is InputEventMouseMotion:
		caminput = event.relative


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rotationv = rotationv.lerp(caminput * mousesens, delta * smoothness)
	rotate_x(deg_to_rad(caminput.y))
	rotate_y(deg_to_rad(caminput.x))
	rotation_degrees.x = clamp(rotation_degrees.x, -90, 90)
	caminput = Vector2.ZERO
	if Input.is_action_pressed("escape"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
