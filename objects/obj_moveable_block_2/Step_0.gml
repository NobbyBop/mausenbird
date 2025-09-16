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

	gravspd = 0
	
	var goal_x = clamp(mouse_x - offset_x, left_bound, right_bound-sprite_width)
	var goal_y = clamp(mouse_y - offset_y, top_bound, bottom_bound-sprite_width)
	
	
	while place_meeting(goal_x, y, obj_block) && goal_x != prev_x{
		goal_x -= sign(goal_x-prev_x)
	}
	
	while place_meeting(goal_x, goal_y, obj_block) && goal_y != prev_y{
		goal_y -= sign(goal_y-prev_y)
	}
	
	prev_x  = x
	prev_y = y
	
	x = round(goal_x)
	y = round(goal_y)
	

} else {
	gravspd = clamp(grav + gravspd, 0, maxgrav)
	var goal_y = clamp(y + gravspd, top_bound, bottom_bound-sprite_width)
	while place_meeting(x, goal_y, obj_block){
		gravspd = 0
		goal_y--
	}
	if goal_y == bottom_bound-sprite_width {
		gravspd = 0
	}
	
	prev_x = x
	prev_y = y
	x = round(x + (x - prev_x))
	y = round(goal_y)
}

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