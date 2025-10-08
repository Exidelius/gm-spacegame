/// @description Initialize base unit object parameters
/// @param {real} _max_health
/// @param {real} _max_armor
/// @param {real} _energy_capacity
/// @param {real} _speed_limit
/// @param {real} _acceleration
/// @param {real} _rotation_speed
function init_object(_max_health, _max_armor, _energy_capacity, _speed_limit, _acceleration, _rotation_speed) {
	// TODO: load saved values or...

	self._max_health = _max_health;
	self._max_armor = _max_armor;
	self._energy_capacity = _energy_capacity;
	self._speed_limit = _speed_limit;
	self._acceleration = _acceleration;
	self._rotation_speed = _rotation_speed;
	
	self._current_health = self._max_health;
	self._current_armor = self._max_armor;
	self._current_energy = self._energy_capacity;
	
	self._current_speed_horizontal = 0;
	self._current_speed_vertical = 0;
	self._object_angle = 0;
	
	// TODO: Should be changed by manager object
	self._space_resistance = 0.05;
}

/// @description Move object using directions
/// @param {real} horizontal_direction -1 or +1
/// @param {real} vertical_direction -1 or +1
function move(horizontal_direction, vertical_direction) {
	_angle_rad = degtorad(self._object_angle);
	
	_rotated_x = horizontal_direction * sin(_angle_rad) - vertical_direction * cos(_angle_rad);
	_rotated_y = horizontal_direction * cos(_angle_rad) + vertical_direction * sin(_angle_rad);
	
	self._current_speed_horizontal = _calculate_speed(self._current_speed_horizontal, _rotated_x);
	self._current_speed_vertical = _calculate_speed(self._current_speed_vertical, _rotated_y);
	
	x += self._current_speed_horizontal;
	y += self._current_speed_vertical;
}

/// @description Rotate object using target coords
/// @param {real} x_direction
/// @param {real} y_direction
function rotate_to_target(x_direction, y_direction) {
	_target_angle = point_direction(x, y, x_direction, y_direction);
	_angle_diff = angle_difference(_target_angle, self._object_angle);
	
	self._object_angle += clamp(_angle_diff, -self._rotation_speed, self._rotation_speed);
	
	image_angle = self._object_angle;
	direction = self._object_angle;
}

/// @description Rotate object using direction
/// @param {real} rotate_direction -1 to left, +1 to right
function rotate_manually(rotate_direction) {
	self._object_angle -= clamp(90 * rotate_direction, -self._rotation_speed, self._rotation_speed);
	
	image_angle = self._object_angle;
	direction = self._object_angle;
}

/// @description Calculate speed
/// @param {real} current_value
/// @param {real} speed_direction
/// @return {real} Calculated speed with acceleration or space resistance
function _calculate_speed(current_value, speed_direction) {
	if speed_direction != 0 {
		return current_value + (speed_direction * self._speed_limit - current_value) * self._acceleration;
	}
	else {
		return current_value * (1 - self._space_resistance);
	}
}