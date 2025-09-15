var mouse_on_me = position_meeting(mouse_x, mouse_y, self)
var clicked = mouse_check_button_pressed(1)
var held = mouse_check_button(1)

if clicked && mouse_on_me {
	moving = true
	offset_x = mouse_x - x
	offset_y = mouse_y - y
}
if !held {
	moving = false
}

if moving {

	var goal_x = mouse_x - offset_x;
	var goal_y = mouse_y - offset_y;

	if (point_distance(x, y, goal_x, goal_y) > maxspd) {
	    var dir = point_direction(x, y, goal_x, goal_y);
	    goal_x = x + lengthdir_x(maxspd, dir);
	    goal_y = y + lengthdir_y(maxspd, dir);
	} 
	
	goal_x = clamp(round(goal_x), left_bound, right_bound-sprite_width)
	goal_y = clamp(round(goal_y), top_bound, bottom_bound-sprite_width)
	
	while place_meeting(goal_x, y, obj_block) && goal_x != prev_x{
		goal_x -= sign(goal_x-prev_x)
	}
	
	while place_meeting(goal_x, goal_y, obj_block) && goal_y != prev_y{
		goal_y -= sign(goal_y-prev_y)
	}
	
	prev_x  = x
	prev_y = y
	
	x = goal_x
	y = goal_y
	
	// Player movement code!
	if place_meeting(prev_x, prev_y-1, obj_maus){
		var new_maus_x = obj_maus.x + (x-prev_x)
		var new_maus_y = obj_maus.y + (y-prev_y)
		var max_iterations = 16 //half of one block size
		var current_iterations = 0
		with obj_maus{
			while place_meeting(new_maus_x, new_maus_y, obj_block) && current_iterations < max_iterations{
				if other.x - other.prev_x == 0 {
					new_maus_x -= 1
				} else {
					new_maus_x -= sign(other.x - other.prev_x)
				}
				current_iterations++
			}
			
			if current_iterations == max_iterations{
				show_debug_message("crushed")
				room_restart()
			}
			
			x = new_maus_x
			y = new_maus_y
		}
		
	}
	
	while place_meeting(prev_x, y, obj_maus){
		obj_maus.y += sign(y - prev_y)
	}
	
	while place_meeting(x, y, obj_maus){
		obj_maus.x += sign(x - prev_x)
	}

}
