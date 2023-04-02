extends Node3D

func _ready():
	var spooder = $spooder
	spooder.transform.origin = Vector3(-5.14, 5.489, -22.66)
	spooder.rotation_degrees = Vector3(0, 80.9, 10)
	$Player.transform.origin = Vector3(2.633, 2.493, -3.588)
