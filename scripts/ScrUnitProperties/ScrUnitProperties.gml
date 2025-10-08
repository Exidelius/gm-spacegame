/// @description Initialize base unit object parameters
/// @param {real} _max_health
/// @param {real} _max_armor
/// @param {real} _energy_capacity
/// @param {real} _speed_limit
/// @param {real} _acceleration
function init_object(_max_health, _max_armor, _energy_capacity, _speed_limit, _acceleration) {
	// TODO: load saved values or...

	self._max_health = _max_health;
	self._max_armor = _max_armor;
	self._energy_capacity = _energy_capacity;
	self._speed_limit = _speed_limit;
	self._acceleration = _acceleration;
	
	self._current_health = self._max_health;
	self._current_armor = self._max_armor;
	self._current_energy = self._energy_capacity;
	
	self._current_speed_horizontal = 0;
	self._current_speed_vertical = 0;
}

/// @description Object movement based on direction
/// @param {bool} _move_left
/// @param {bool} _move_right
/// @param {bool} _move_up
/// @param {bool} _move_down
function move(_move_left, _move_right, _move_up, _move_down) {
	self._current_speed_horizontal = _calculate_speed(self._current_speed_horizontal, _move_right - _move_left);
	self._current_speed_vertical = _calculate_speed(self._current_speed_vertical, _move_down - _move_up)
	
	// TODO: check collision
	x += self._current_speed_horizontal
	y += self._current_speed_vertical
}

/// @description Calculate speed
/// @param {real} _current_value
/// @param {real} _speed_direction
/// @return {real}
function _calculate_speed(_current_value, _speed_direction) {
	if _speed_direction != 0 {
		return _current_value + (_speed_direction * self._speed_limit - _current_value) * self._acceleration;
	}
	else {
		// TODO: add space resistance value instead of 0.1
		return _current_value - 0.1 * _current_value;
	}
}