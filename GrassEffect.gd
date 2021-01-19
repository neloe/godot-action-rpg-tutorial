extends Node2D

onready var animatedSprite = $AnimatedSprite

func _ready():
	animatedSprite.frame = 0
	animatedSprite.play("Animate")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	if Input.is_action_just_pressed("attack"):
#		animatedSprite.frame = 0
#		animatedSprite.play("Animate")


func _on_AnimatedSprite_animation_finished():
	queue_free()
