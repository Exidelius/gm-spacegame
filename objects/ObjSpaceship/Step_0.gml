ship.life_cycle();

var h_direction = keyboard_check(vk_right) - keyboard_check(vk_left);
var v_direction = keyboard_check(vk_down) - keyboard_check(vk_up);

ship.move(0, v_direction);
ship.rotate_manually(h_direction);
ship.apply_transform(id);
