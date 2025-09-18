moving = false
MAXSPD = 2

GRAV = .1
gravspd = 0
MAXGRAV  = 5

prev_x = x
prev_y = y

LEFT_BOUND = 0
RIGHT_BOUND = room_width
TOP_BOUND = 0
BOTTOM_BOUND = room_height

if place_meeting(x, y, obj_boundary_2){
	var boundary = instance_place(x, y, obj_boundary_2)
	
	LEFT_BOUND = boundary.bbox_left
	RIGHT_BOUND = boundary.bbox_right
	TOP_BOUND = boundary.bbox_top
	BOTTOM_BOUND = boundary.bbox_bottom
}