/// @description Initialize base Gun object parameters
/// @param {real} damage
/// @param {struct} rotation_speed
/// @param {any} parent_id
/// @param {any} bullet_obj
function Gun(damage, rotation_speed, parent_id, bullet_obj) constructor {
	self._damage = damage;
	self._bullet_obj = bullet_obj;
	self._speed = {
		rotation: rotation_speed
	};
	self._pos = {
		x: 0,
		y: 0
	};
	self._angle = 0;
	self._parent_id = parent_id;

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
	
	self.attack = function() {
		var bullet_id = instance_create_layer(
			self._pos.x,
			self._pos.y,
			"Instances",
			self._bullet_obj
		);
		bullet__id.bullet = Bullet()
	}
	
	/// @description Process all entity's static events
	self.life_cycle = function() {
		self._speed.rotation.life_cycle();
		self._pos.x = self._parent_id.x;
		self._pos.y = self._parent_id.y;
	}
		
	/// @description Set object base position
	/// @param {real} new_x
	/// @param {real} new_y
	/// @param {real} new_angle
	self.set_transform = function(new_x = 0, new_y = 0, new_angle = undefined) {
		self._pos.x = new_x;
		self._pos.y = new_y;
		if self._angle != undefined self._angle = new_angle;
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
