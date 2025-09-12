
// Get info about moving platform if colliding
//var on_platform = place_meeting(x, y+1, obj_moveable_block)
//if on_platform {
//	var block = instance_place(x, y+1, obj_moveable_block)
//	if(y < block.bbox_top){
//		x += block.x - block.prev_x
//		while !place_meeting(x, y, block){
//			y++
//		}
//		y--
//	}
//}

// Handle player's desired movement.
var on_ground = place_meeting(x, y+1, obj_block)
var on_ceiling = place_meeting(x, y-1, obj_block)
if (on_ground) cur_vspd = 0
on_ground_buffer = on_ground ? 3 : max(0, on_ground_buffer - 1)
jump_buffer = keyboard_check_pressed(ord("W")) ? 3 : max(0, jump_buffer - 1)
var jump = jump_buffer > 0 && on_ground_buffer > 0
if (jump) {
    jump_buffer = 0
    on_ground_buffer = 0
    cur_vspd = vspd
} else if (on_ceiling) {
    cur_vspd = grav
} else {
    cur_vspd += grav
}
var horiz_dir = keyboard_check(ord("D")) - keyboard_check(ord("A"))
var goal_x = x + horiz_dir * hspd
var goal_y = y + cur_vspd
while (place_meeting(goal_x, goal_y, obj_block)) {

	if place_meeting(goal_x, goal_y, obj_block){
		goal_x -= horiz_dir
        goal_y -= sign(cur_vspd)
    }
    else {
		if place_meeting(goal_x, y, obj_block){
		goal_x -= horiz_dir
	    }
	    if place_meeting(x, goal_y, obj_block){
	        goal_y -= sign(cur_vspd)
	    }
	}
}

x = goal_x
y = goal_y

while (place_meeting(x, y, obj_block)) {
	x -= horiz_dir
    y -= sign(cur_vspd)
}