extends KinematicBody2D

const FRICTION = 400
const ACCELERATION = 100
const MAX_SPEED = 60

var velocity = Vector2.ZERO

#Animations
onready var animationPlayerAzeroth = $Azeroth/AnimationAzeroth
onready var animationAzerothTree = $Azeroth/AnimationTree
onready var animationPlayerPeb = $Peb/AnimationPeb
onready var animationPebTree = $Peb/AnimationTree

onready var animationPebstate = animationPebTree.get("parameters/playback")



func _physics_process(delta):
	var input_vector = Vector2.ZERO
	
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animationPebTree.set("parameters/Idle/blend_position" , input_vector)
		animationAzerothTree.set("parameters/Position/blend_position" , input_vector)
		animationPebTree.set("parameters/Run/blend_position" , input_vector)
		animationPebstate.travel("Run")
		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
		
	else:
		animationPebstate.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		
	velocity = move_and_slide(velocity)
