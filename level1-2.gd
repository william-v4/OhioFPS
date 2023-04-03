extends Node3D
var stage = 1
signal restart(stage)
var spooder

func playerreset():
	$Player.transform.origin = Vector3(2.633, 2.493, -3.588)

func _ready():
	spooder = $spooder
	spooder.transform.origin = Vector3(-5.14, 5.489, -22.66)
	spooder.rotation_degrees = Vector3(0, 80.9, 10)
	playerreset()

func reset(difficulty):
	if difficulty == 2:
		add_child(load("res://spooder.tscn").instantiate())
		emit_signal("restart", difficulty)
		playerreset()
	if difficulty > 2:
		for i in difficulty * 2:
			add_child(load("res://spooder.tscn").instantiate())
		emit_signal("restart", difficulty)
		playerreset()

func _on_area_3d_body_entered(body):
	if body.name == "Player":
		stage += 1
		reset(stage)
		print("spooder position:" + str(position.x, position.y, position.z))
