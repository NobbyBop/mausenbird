view_enabled = true
view_set_visible(0, true)
view_set_xport(0, 0)
view_set_yport(0, 0)
view_set_wport(0, global.SCREEN_WIDTH)  // Keep at base resolution
view_set_hport(0, global.SCREEN_HEIGHT)
cameraId = camera_create_view(0, 0, global.SCREEN_WIDTH, global.SCREEN_HEIGHT)
view_set_camera(0, cameraId)

var dwidth = display_get_width();
var dheight = display_get_height();
var xpos = (dwidth / 2) - (global.SCREEN_WIDTH * global.SCREEN_SCALE / 2);
var ypos = (dheight / 2) - (global.SCREEN_HEIGHT * global.SCREEN_SCALE / 2);
window_set_rectangle(xpos, ypos, global.SCREEN_WIDTH * global.SCREEN_SCALE, global.SCREEN_HEIGHT * global.SCREEN_SCALE);
surface_resize(application_surface, global.SCREEN_WIDTH, global.SCREEN_HEIGHT); // Keep original size