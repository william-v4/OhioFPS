extends RigidBody3D

func _physics_process(delta):
	if Input.is_action_pressed('shoot') and not $AnimationPlayer.is_playing():
		$AnimationPlayer.play("fire")
		$AudioStreamPlayer.set_pitch_scale(randf_range(0.5,1.5))
		$AudioStreamPlayer.play()
