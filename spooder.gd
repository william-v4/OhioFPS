extends CharacterBody3D
var health = 40
var alive = 1
var speed = 0.5
var target
var space_state
var chasedir

func _ready():
	space_state = get_world_3d().direct_space_state
	

func _on_player_hit(object):
	if object == self and alive == 1:
		health -= 1
		$AnimationPlayer.play("hurt")
		print("hit")


func _process(delta):
	if health < 0:
		health = 0	
	
	if health == 0:
		alive = 0
		$AnimationPlayer.play("die")
		var t = Timer.new()
		t.set_wait_time(2)
		t.set_one_shot(true)
		self.add_child(t)
		t.start()
		await t.timeout
		queue_free()
		
	if target:
		var rayparams = PhysicsRayQueryParameters3D.new()
		rayparams.from = global_transform.origin
		rayparams.to = target.global_transform.origin
		rayparams.collision_mask = 1
		var result = space_state.intersect_ray(rayparams)
		if result and result.collider.name == "Player":
			var lookdir = target.global_transform.origin
			lookdir.x -= 90
			look_at(target.global_transform.origin, Vector3.UP)
			rotation.y -= 90
			chasedir = (target.transform.origin - transform.origin).normalized()
			velocity = chasedir
			move_and_slide()
		else:
			pass
			
		


func _on_area_3d_body_entered(body):
	print("intruder detected")
	print(body)
	print(body.name)
	if body.name == "Player":
		target = body
		print("target locked")
	else:
		pass
		


func _on_area_3d_body_exited(body):
	if body.name == "Player":
		target = null
		print("target lost")


func _on_player_hurt():
	var knockdir = target.transform.origin.direction_to(transform.origin)
	var knock = knockdir * 10
	velocity -= chasedir * 2
