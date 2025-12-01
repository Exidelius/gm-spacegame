/// @description Initialize base Spaceship
/// @param {VitalParam} new_health
/// @param {VitalParam} new_shield
/// @param {RestorableParam} new_energy
/// @param {SpeedParam} new_movement_speed
/// @param {SpeedParam} new_rotation_speed
/// @param {any} weapon_id
function Spaceship(new_health, new_shield, new_energy, new_movement_speed, new_rotation_speed, weapon_id) constructor {
	self.health = new_health;
	self.shield = new_shield;
	self.energy = new_energy;
	self._speed = {
		horizontal: new_movement_speed.copy(),
		vertical: new_movement_speed.copy(),
		rotation: new_rotation_speed
	}
	self._pos = {
		x: 0,
		y: 0
	}
	self._angle = 0;

	/// @description Set new space resistance
	/// @param {real} new_resistance
	self.set_space_resistance = function(new_resistance) {
		self._speed.horizontal.resistance = new_resistance;
		self._speed.vertical.resistance = new_resistance;
		self._speed.rotation.resistance = new_resistance;
	}
	
	/// @description Move object using directions
	/// @param {real} horizontal_direction -1 or +1
	/// @param {real} vertical_direction -1 or +1
	self.move = function(horizontal_direction, vertical_direction) {
		var _angle_rad = degtorad(self._angle);
	
		var _rotated_x = horizontal_direction * sin(_angle_rad) - vertical_direction * cos(_angle_rad);
		var _rotated_y = horizontal_direction * cos(_angle_rad) + vertical_direction * sin(_angle_rad);
	
		self._speed.horizontal.increase(_rotated_x);
		self._speed.vertical.increase(_rotated_y);
		
		self._pos.x += self._speed.horizontal.current;
		self._pos.y += self._speed.vertical.current;
	}
	
	/// @description Rotate object using target coords
	/// @param {real} x_direction
	/// @param {real} y_direction
	self.rotate_to_target = function(x_direction, y_direction) {
		var _target_angle = point_direction(self._pos.x, self._pos.y, x_direction, y_direction);
		var _angle_diff = angle_difference(_target_angle, self._angle);
		self._speed.rotation.increase(sign(_angle_diff))

		self._angle += clamp(_angle_diff, -self._speed.rotation.current, self._speed.rotation.current);
	}
	
	/// @description Rotate object using direction
	/// @param {real} rotate_direction -1 to left, +1 to right
	self.rotate_manually = function(rotate_direction) {
		self._speed.rotation.increase(rotate_direction)
		self._angle -= self._speed.rotation.current;
	}
	
	/// @description Process all entity's static events
	self.life_cycle = function() {
		self.health.life_cycle();
		self.shield.life_cycle();
		self.energy.life_cycle();
		self._speed.horizontal.life_cycle();
		self._speed.vertical.life_cycle();
		self._speed.rotation.life_cycle();
	}
		
	/// @description Set object base position
	/// @param {real} new_x
	/// @param {real} new_y
	/// @param {real} new_angle
	self.set_transform = function(new_x = 0, new_y = 0, new_angle = 0) {
		self._pos.x = new_x;
		self._pos.y = new_y;
		self._angle = new_angle;
	}
	
	/// @description Apply transform to the actual object instance
	/// @param {id} instance
	self.apply_transform = function(instance) {
		instance.x = self._pos.x;
		instance.y = self._pos.y;
		instance.image_angle = self._angle;
		instance.direction = self._angle;
	}
}
