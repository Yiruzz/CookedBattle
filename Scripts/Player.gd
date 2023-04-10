extends CharacterBody2D


const SPEED = 300.0
@onready var anim = $AnimationPlayer
@export var BtnDer = "ui_right"
@export var BtnIzq = "ui_left"
@export var BtnArr = "ui_up"
@export var BtnAbj = "ui_down"
var ingrediente = null

func atacar():
	pass

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func entregaIngrediente(Cocina):
	pass

func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	

	var dir = Vector2(Input.get_axis(BtnIzq, BtnDer),Input.get_axis(BtnArr, BtnAbj))
	velocity = dir*SPEED
	
	
	if (velocity.length() > 0 ):
		anim.play("run")
		if(velocity.x > 0):
			$Sprite2D.flip_h = false
		else:
			$Sprite2D.flip_h = true
	else:
		anim.play("Idle")
		
	
	#if direction:
	#	velocity.x = direction * SPEED
	#else:
	#velocity.x = move_toward(vel.x, vel.y, SPEED)

	move_and_slide()
	


