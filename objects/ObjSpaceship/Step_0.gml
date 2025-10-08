var h_direction = keyboard_check(vk_right) - keyboard_check(vk_left);
var v_direction = keyboard_check(vk_down) - keyboard_check(vk_up);

move(0, v_direction);

//rotate_to_target(mouse_x, mouse_y);
rotate_manually(h_direction);
