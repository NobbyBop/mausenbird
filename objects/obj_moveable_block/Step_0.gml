var mouse_on_me = position_meeting(mouse_x, mouse_y, self)
var maus_on_me = false
if instance_exists(obj_maus){
	maus_on_me = (obj_maus.bbox_left > bbox_left && obj_maus.bbox_left < bbox_right ||
	obj_maus.bbox_right > bbox_left && obj_maus.bbox_right < bbox_right) &&
	(obj_maus.bbox_bottom > bbox_top - 2 && obj_maus.bbox_bottom < bbox_top + 2)
}
show_debug_message("maus on me?:", string(maus_on_me))
var clicked = mouse_check_button_pressed(1)
var held = mouse_check_button(1)

if clicked && mouse_on_me {
	moving = true
	offset_x = mouse_x - x
	offset_y = mouse_y - y
	show_debug_message("held: " + string(held))
}
if !held {
	moving = false
}

if moving {
	
	//offset_x = mouse_x - x
	//offset_y = mouse_y - y
	//var distance = distance_to_point(mouse_x, mouse_y)
	//var change_x = sign() * maxspd	
	//var change_y = sign() * maxspd
	
	//var pythagorus = sqrt(sqr(change_x) + sqr(change_y))
	//var clamp_x = clamp(change_x, -pythagorus, pythagorus)
	//var clamp_y = clamp(change_y, -pythagorus, pythagorus)
	
	//x += clamp_x
	//y += clamp_y
	prev_x  = x
	prev_y = y
	x = clamp(mouse_x - offset_x, left_bound, right_bound-sprite_width)
	y = clamp(mouse_y - offset_y, top_bound, bottom_bound-sprite_width)
	
}
