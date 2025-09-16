moving = false
maxspd = 1.5
offset_x = 0
offset_y = 0

grav = .1
gravspd = 0
maxgrav = 5

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