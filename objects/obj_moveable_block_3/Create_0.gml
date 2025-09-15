moving = false
maxspd = 1.5
offset_x = 0
offset_y = 0

// Mode is 0 when you have yet to select the block,
// 1 when you have yet to select the destination
// 2 when it is in motion and cannot be interrupted
mode = 0

prev_x = x
prev_y = y

left_bound = 0
right_bound = room_width
top_bound = 0
bottom_bound = room_height

if place_meeting(x, y, obj_boundary){
	var boundary = instance_place(x, y, obj_boundary)
	
	left_bound = boundary.bbox_left
	right_bound = boundary.bbox_right
	top_bound = boundary.bbox_top
	bottom_bound = boundary.bbox_bottom
}