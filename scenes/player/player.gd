extends CharacterBody2D

signal laser(pos, directions);
signal grenade(pos, direction);

var can_laser: bool  = true
var can_grenade: bool  = true

func _ready():
	pass 



func _process(_delta):
	
	#input 
	
	var direction = Input.get_vector("left","right","up","down");
	velocity = direction * 500
	move_and_slide()
	
	# rotate
	look_at(get_global_mouse_position())
		
	var player_direction = (get_global_mouse_position() - position).normalized()

	if(Input.is_action_just_pressed("primary action") and can_laser):
		var laser_markers = $LaserStartPosition.get_children()
		var selected_laser = laser_markers[randi() % laser_markers.size()]

		laser.emit(selected_laser.global_position, player_direction);
		can_laser = false;
		$LaserReloadTimer.start()
		
	if(Input.is_action_just_pressed("secondary action") and can_grenade):
		var pos = $LaserStartPosition.get_children()[0].global_position

		grenade.emit(pos, player_direction)
		can_grenade = false;
		$GrenadeReloadTimer.start()
		
func _on_grenade_reload_timer_timeout() -> void:
	can_grenade = true;


func _on_laser_reload_timer_timeout() -> void:
	can_laser = true;
