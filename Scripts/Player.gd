extends CharacterBody2D


const SPEED = 300.0



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")




func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	

	var dir = Vector2(Input.get_axis("ui_left", "ui_right"),Input.get_axis("ui_up", "ui_down"))
	velocity = dir*SPEED
	
	#if direction:
	#	velocity.x = direction * SPEED
	#else:
	#velocity.x = move_toward(vel.x, vel.y, SPEED)

	move_and_slide()
	

