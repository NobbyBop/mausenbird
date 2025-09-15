// Returns an array of colliding bboxes.
function get_colliding_bboxes(maus, block){
    var colliding_bboxes = [];
    
    // Check if actually colliding
    if (!rectangle_in_rectangle(maus.bbox_left, maus.bbox_top, maus.bbox_right, maus.bbox_bottom,
                               block.bbox_left, block.bbox_top, block.bbox_right, block.bbox_bottom)) {
        return colliding_bboxes;
    }
    
    // Check horizontal overlap (left/right sides)
    if (maus.bbox_left < block.bbox_right && maus.bbox_right > block.bbox_left) {
        if (maus.bbox_top < block.bbox_top && maus.bbox_bottom > block.bbox_top) {
            // Colliding with top side
            array_push(colliding_bboxes, "top");
        }
        if (maus.bbox_top < block.bbox_bottom && maus.bbox_bottom > block.bbox_bottom) {
            // Colliding with bottom side  
            array_push(colliding_bboxes, "bottom");
        }
    }
    
    // Check vertical overlap (top/bottom sides)
    if (maus.bbox_top < block.bbox_bottom && maus.bbox_bottom > block.bbox_top) {
        if (maus.bbox_left < block.bbox_left && maus.bbox_right > block.bbox_left) {
            // Colliding with left side
            array_push(colliding_bboxes, "left");
        }
        if (maus.bbox_left < block.bbox_right && maus.bbox_right > block.bbox_right) {
            // Colliding with right side
            array_push(colliding_bboxes, "right");
        }
    }
	
	show_debug_message("bbox_array: [" + string(colliding_bboxes) + "]");
    
    return colliding_bboxes;
}