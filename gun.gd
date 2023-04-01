extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("shoot") and not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("knockback")
		$laser/AnimationPlayer.play("fire")
		$AudioStreamPlayer.set_pitch_scale(randf_range(0.4, 1.4))
		$AudioStreamPlayer.play()
	if not $AnimationPlayer.is_playing():
		$laser/MeshInstance3D.mesh.set_height(0.5)
		
