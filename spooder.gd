extends CharacterBody3D
var health = 40
var alive = 1
var speed = 0.5
var target
var space_state
var chasedir
var dedrepeat = 0

func _ready():
	print(get_parent_node_3d())
	get_parent_node_3d().restart.connect(_on_level_1_restart)
	space_state = get_world_3d().direct_space_state
	$"../Player".hit.connect(_on_player_hit)
	add_to_group("enemylevel1")
	print(health)

func _on_player_hit(object):
	if object == self and alive == 1:
		health -= 1
		$AnimationPlayer.play("hurt")
		print("enemyhealth:" + str(health))

func _process(_delta):
	if health < 0:
		health = 0	
	if health == 0:
		alive = 0
		if dedrepeat == 0:
			Signalbus.emit_signal("ded")
			remove_child($CollisionShape3D)
			dedrepeat = 1
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
			move_and_slide()

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

func _on_level_1_restart(stage):
	var offset = ["x", "y", "z"]
	speed = stage % 5
	if stage == 2:
		print("evolved")
		health = 160
		if not $AnimationPlayer.is_playing():
			transform.origin = Vector3(-5.5, 1.783, -11.25)
			rotation_degrees = Vector3(0, 80.9, 10)
			$Area3D/CollisionShape3D.shape.radius = 20
	if stage > 2:
		randomize()
		var region = int(randi() % 2)
		print("gen1:" + str(region))
		if region == 0:
			const randompositionsx = [-3.5, -5.5,]
			const randompositionsy = [1.783, 3.783,]
			const randompositionsz = [-11.25, -10.25, -13.25]
			global_transform.origin = Vector3(randompositionsx[int(randi() % randompositionsx.size())], randompositionsy[int(randi() % randompositionsy.size())], randompositionsz[int(randi() % randompositionsz.size())],)
			rotation_degrees = Vector3(0, 80.9, 10)
		if region == 1:
			var region2 = int(randi() % 2)
			print("gen2:" + str(region2))
			if region2 == 0:
				global_transform.origin = Vector3(-4.99, 5.367, -23.77)
			if region2 == 1:
				global_transform.origin = Vector3(7.981, 5.367, -22.74)
		$Area3D/CollisionShape3D.shape.radius = 20
	if stage > 10:
		$Area3D/CollisionShape3D.shape.radius = 40
		speed = 1
