// player movement constants
HSPD = 3
VSPD_CURVE = [-8, -4, -2, -1, -.75]
MAX_VSPD = -5
// In frames
MAX_JUMPTIME = 20
GRAV_CURVE = [3, 5, 7]
TERMINAL_V = 10

// current vertical speed - incremental
cur_vspd = 0

// buffers
jump_buffer = 0
jump_end_timer = 0
fall_time = 0
on_ground_buffer = 0
on_ground = false