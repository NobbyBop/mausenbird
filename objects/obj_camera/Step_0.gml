if instance_exists(obj_maus){
    var cam_x = clamp(obj_maus.x - camera_get_view_width(cameraId)/2, 0, room_width)
    var cam_y = clamp(obj_maus.y - camera_get_view_height(cameraId)/2, 0, room_height - camera_get_view_width(cameraId))
    camera_set_view_pos(cameraId, cam_x, cam_y)
}