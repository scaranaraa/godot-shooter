extends CharacterBody2D



func _ready() -> void:
	pass 



func _process(_delta: float) -> void:
	
	var direction = Vector2.RIGHT;
	
	velocity = direction * 400;
	move_and_slide()
