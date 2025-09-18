// First, check if we're getting crushed.
if (place_meeting(x, y+1, obj_block) &&  place_meeting(x, y-1, obj_block)) ||
(place_meeting(x-1, y, obj_block) &&  place_meeting(x+1, y, obj_block)) {
	show_debug_message("crushed")
	room_restart()
}

var on_ground = place_meeting(x, y+1, obj_block)
var on_ceiling = place_meeting(x, y-1, obj_block)

on_ground_buffer = on_ground ? 3 : max(0, on_ground_buffer - 1)
jump_buffer = keyboard_check_pressed(ord("W")) ? 3 : max(0, jump_buffer - 1)

var jump = jump_buffer > 0 && on_ground_buffer > 0
if jump {
    jump_buffer = 0
    on_ground_buffer = 0
    cur_vspd = VSPD
} else if on_ceiling {
    if cur_vspd <= 0 {
		cur_vspd = GRAV
	} else {
		cur_vspd += GRAV
	}
} else if on_ground {
	cur_vspd = 0
} else {
    cur_vspd += GRAV
	cur_vspd = clamp(cur_vspd, VSPD, TERMINAL_V)
}

var horiz_dir = keyboard_check(ord("D")) - keyboard_check(ord("A"))
var goal_x = x + horiz_dir * HSPD
var goal_y = y + cur_vspd

if horiz_dir != 0 {
	while place_meeting(goal_x, y, obj_block){
		goal_x -= sign(horiz_dir)
	}
}

if cur_vspd != 0 {
	while place_meeting(goal_x, goal_y, obj_block){
		goal_y -= sign(cur_vspd)
	}
}

x = goal_x
y = goal_y