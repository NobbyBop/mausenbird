var mouse_on_me = position_meeting(mouse_x, mouse_y, self)
var clicked = mouse_check_button_pressed(1)
var held = mouse_check_button(1)

if clicked && mouse_on_me {
	moving = true
}
if !held {
	moving = false
}

if moving && !mid_move{
    
    mid_move = true

	var dir = point_direction(x + sprite_width/2, y + sprite_height/2, mouse_x, mouse_y);

    if !position_meeting(mouse_x, mouse_y, self) {
        if (dir >= 315 || dir < 45) {
            move_mode = "right"
            prev_dest_x = dest_x
            dest_x = x + sprite_width
        } else if (dir >= 45 && dir < 135) {
            move_mode = "up"
            prev_dest_y = dest_y
            dest_y = y - sprite_height
        } else if (dir >= 135 && dir < 225) {
            move_mode = "left"
            prev_dest_x = dest_x
            dest_x = x - sprite_width
        } else if (dir >= 225 && dir < 315) {
            move_mode = "down"
            prev_dest_y = dest_y
            dest_y = y + sprite_height
        }
    }
}

if (x != dest_x || y != dest_y){
    prev_x = x
    prev_y = y
    var goal_x = x
    var goal_y = y
    switch move_mode {
        case "right":
            goal_x = clamp(x + MAXSPD, x, dest_x)
            break;
        case "left":
            goal_x = clamp(x - MAXSPD, dest_x, x)
            break;
        case "up":
            goal_y = clamp(y - MAXSPD, dest_y, y)
            break;
        case "down":
            goal_y = clamp(y + MAXSPD, y, dest_y)
            break;
    }
    
    if place_meeting(goal_x, y, obj_block) && goal_x != prev_x{
		dest_x = prev_dest_x
        if move_mode = "right"{
            move_mode = "left"
            goal_x = clamp(x - MAXSPD, dest_x, x)
        } else {
            move_mode = "right"
            goal_x = clamp(x + MAXSPD, x, dest_x)
        }
	}
    
	
	if place_meeting(x, goal_y, obj_block) && goal_y != prev_y{
		dest_y = prev_dest_y
        if move_mode = "up"{
            move_mode = "down"
            goal_y = clamp(y + MAXSPD, y, dest_y)
        } else {
            move_mode = "up"
            goal_y = clamp(y - MAXSPD, dest_y, y)
        }
	}
    
    
    x = goal_x
    y = goal_y
    
} else {
    mid_move = false
    prev_x = x
    prev_y = y
}
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
