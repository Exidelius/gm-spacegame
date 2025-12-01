function Bullet(bullet_damage, bullet_speed, expiration_time, position, angle) constructor {
	self._damage = bullet_damage;
	self._speed = bullet_speed;
	self._expiration_time = expiration_time;
	self._pos = {
		x: position.x,
		y: position.y
	};
	self._angle = angle;
	
	self.attack = function(target_id) {
		target_id.take_damage(self.damage);
	};
	
	self.move = function() {
		
	};
	
	self.apply_transform = function(target_id) {
		target_id.x = self._pos.x;
		target_id.y = self._pos.y;
		target_id.direction = self._angle;
		target_id.image_angle = self._angle;
	}
	
	self.life_cycle = function() {
		self._speed.life_cycle();
	};
}