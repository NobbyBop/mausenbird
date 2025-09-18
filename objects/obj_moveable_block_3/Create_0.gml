moving = false
MAXSPD = 1.5
offset_x = 0
offset_y = 0

prev_x = x
prev_y = y

LEFT_BOUND = 0
RIGHT_BOUND = room_width
TOP_BOUND = 0
BOTTOM_BOUND= room_height

if place_meeting(x, y, obj_boundary_3){
	var boundary = instance_place(x, y, obj_boundary_3)
	
	LEFT_BOUND = boundary.bbox_left
	RIGHT_BOUND = boundary.bbox_right
	TOP_BOUND = boundary.bbox_top
	BOTTOM_BOUND= boundary.bbox_bottom
}