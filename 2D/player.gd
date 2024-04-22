extends Area2D
signal hit

@export var speed=400
var screen_size
var click_pos
var direction
var anim
# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size=get_viewport_rect().size
	hide()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity=Vector2.ZERO
	
	if Input.is_action_pressed("move_right"):
		velocity.x+=1
	if Input.is_action_pressed("move_left"):
		velocity.x-=1
	if Input.is_action_pressed("move_up"):
		velocity.y-=1
	if Input.is_action_pressed("move_down"):
		velocity.y+=1
	if Input.is_action_pressed("click"):
		click_pos=get_viewport().get_mouse_position()
		if position!=click_pos:
			direction=click_pos-position
			position+=direction.normalized()*2
			$AnimatedSprite2D.animation="up"
			$AnimatedSprite2D.flip_h=velocity.y>0
			anim=true
	if Input.is_action_just_released("click"):
			anim=false
			pass
		
	
	
	if velocity.length()>0 or anim==true:
		velocity=velocity.normalized()*speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position+=velocity * delta
	position=position.clamp(Vector2.ZERO,screen_size)


func _on_body_entered(body):
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled",true)
	
func start(pos):
	position=pos
	show()
	$CollisionShape2D.disabled=false
	
