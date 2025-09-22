// Goal, create a block that moves in a grid pattern by dragging.
MAXSPD = 1.5
moving = false
mid_move = false
move_mode = "right"
dest_x = x
dest_y = y
prev_dest_x = x
prev_dest_y = y
prev_x = x
prev_y = y

LEFT_BOUND = 0
RIGHT_BOUND = room_width
TOP_BOUND = 0
BOTTOM_BOUND = room_height

if place_meeting(x, y, obj_boundary_1){
	var boundary = instance_place(x, y, obj_boundary_1)
	
	LEFT_BOUND = boundary.bbox_left
	RIGHT_BOUND = boundary.bbox_right
	TOP_BOUND = boundary.bbox_top
	BOTTOM_BOUND = boundary.bbox_bottom
}