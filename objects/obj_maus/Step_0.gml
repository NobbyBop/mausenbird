// First, check if we're getting crushed.
if (place_meeting(x, y+1, obj_block) && place_meeting(x, y-1, obj_block)) && place_meeting(x, y, obj_block)||
(place_meeting(x-1, y, obj_block) && place_meeting(x+1, y, obj_block)) && place_meeting(x, y, obj_block){
	show_debug_message("crushed")
	room_restart()
}

var on_ground = place_meeting(x, y+1, obj_block)
var on_ceiling = place_meeting(x, y-1, obj_block)

on_ground_buffer = on_ground ? 3 : max(0, on_ground_buffer - 1)
jump_buffer = keyboard_check_pressed(ord("W")) ? 3 : max(0, jump_buffer - 1)

var start_jump = jump_buffer > 0 && on_ground_buffer > 0
jump_end_timer = keyboard_check(ord("W")) && not on_ceiling ? jump_end_timer - 1: 0;

if start_jump {
    fall_time = 0
    jump_buffer = 0
    on_ground_buffer = 0
    jump_end_timer = MAX_JUMPTIME
    cur_vspd = VSPD_CURVE[0]
} else if jump_end_timer > 0 {
    var vspd_idx = clamp((floor((MAX_JUMPTIME - jump_end_timer) * array_length(VSPD_CURVE) / MAX_JUMPTIME)), 0, array_length(VSPD_CURVE)-1)
    cur_vspd = VSPD_CURVE[vspd_idx]
} else if on_ceiling {
    if cur_vspd <= 0 {
		cur_vspd = GRAV_CURVE[0]
	} 
    //else {
		//cur_vspd += GRAV
	//}
} else if on_ground {
	cur_vspd = 0
    fall_time = 0
} else {
    var grav_idx = clamp(round(fall_time/(array_length(GRAV_CURVE)*2)), 0, (array_length(GRAV_CURVE)-1))
    show_debug_message(grav_idx)
    cur_vspd = GRAV_CURVE[grav_idx]
	//cur_vspd = clamp(cur_vspd, MAX_VSPD, TERMINAL_V)
    fall_time += 1
}

var horiz_dir = keyboard_check(ord("D")) - keyboard_check(ord("A"))
var goal_x = x + horiz_dir * HSPD
var goal_y = y + cur_vspd

if horiz_dir != 0 {
	while place_meeting(goal_x, y, obj_block){
		goal_x -= sign(horiz_dir)
	}
    //goal_x = round(goal_x)
}

if cur_vspd != 0 {
	while place_meeting(goal_x, goal_y, obj_block){
		goal_y -= sign(cur_vspd)
	}
}

x = goal_x
y = goal_y