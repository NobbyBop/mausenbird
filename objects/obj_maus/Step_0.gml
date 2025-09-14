
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

on_ground_buffer = on_ground ? 3 : max(0, on_ground_buffer - 1)
jump_buffer = keyboard_check_pressed(ord("W")) ? 3 : max(0, jump_buffer - 1)

var jump = jump_buffer > 0 && on_ground_buffer > 0
if jump {
    jump_buffer = 0
    on_ground_buffer = 0
    cur_vspd = vspd
} else if on_ceiling {
    cur_vspd = grav
} else if on_ground {
	cur_vspd = 0
} else {
    cur_vspd += grav
	cur_vspd = clamp(cur_vspd, vspd, terminal_v)
}
var horiz_dir = keyboard_check(ord("D")) - keyboard_check(ord("A"))
var goal_x = x + horiz_dir * hspd
var goal_y = y + cur_vspd

/*
Idea:
1. Get all instances of blocks that maus is colliding with
2. For each one, get a list of bboxes that you are colliding with.
3. Join the lists into a set.
4. If the set contains more than 2 entries (i.e. you have to move up and down) you're crushed.
5. Otherwise, move away from both bboxes by one pixel and repeat until no collisions.
*/
if place_meeting(goal_x, goal_y, obj_block){
    var block_list = ds_list_create()
    var top = false, bottom = false, left = false, right = false;
	var topVal = 0, bottomVal = room_height, leftVal = 0, rightVal = room_width;
    
    instance_place_list(goal_x, goal_y, obj_block, block_list, true);
	
    for(var i=0; i < ds_list_size(block_list); i++){
        var block = block_list[| i]; // Fix: get the actual block instance
        var bbox_array = get_colliding_bboxes(self, block);
        var cur_top = array_contains(bbox_array, "top")
        var cur_bottom = array_contains(bbox_array, "bottom")
        var cur_left = array_contains(bbox_array, "left")
        var cur_right = array_contains(bbox_array, "right")
		
		if cur_top {
			topVal = min(block.bbox_top, topVal)
		}
		if cur_bottom {
			bottomVal = max(block.bbox_bottom, bottomVal)
		}
		if cur_left {
		    leftVal = min(block.bbox_left, leftVal)
		}
		if cur_right {
		    rightVal = max(block.bbox_right, rightVal)
		}
	}
	
	if top {
        goal_y = topVal - (bbox_bottom - y)
    }
    if bottom {
        goal_y = bottomVal - (bbox_top - y)
    }
    if left {
        goal_x = leftVal - (bbox_right - x)
    }
    if right {
        goal_x = rightVal - (bbox_left - x)
    }
	
}

x = goal_x
y = goal_y
