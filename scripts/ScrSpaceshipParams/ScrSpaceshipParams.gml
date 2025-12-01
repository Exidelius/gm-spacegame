/// @description Base constructor for params of an entity
/// @param {real} max_value
/// @param {real} current_value
function BaseParam(max_value, current_value = undefined) constructor {
	self.max = max_value;
	self.current = current_value ?? max_value;

	self.decrease = function(value) {
		var difference = self.current - value;
		self.current = difference <= 0 ? 0 : difference;
	}
	
	self.increase = function(value) {
		if self.current >= self.max return;
		self.current += value;
		if self.current >= self.max self.current = self.max;
	}
	
	self.life_cycle = function() {}
}

/// @description Constructor for restorable params of an entity
/// @param {real} max_value
/// @param {real} current_value
/// @param {real} restore_rate
function RestorableParam(max_value, current_value = undefined, restore_rate = 0) : BaseParam(max_value, current_value) constructor {
	self.restore_rate = restore_rate;
	
	self.life_cycle = function() {
		if self.restore_rate != 0 self.increase(self.restore_rate);
	}
}

/// @description Constructor for vital params (hp, shield) of an entity
/// @param {real} max_value
/// @param {real} current_value
/// @param {real} restore_rate
/// @param {real} resistance
function VitalParam(max_value, current_value = undefined, restore_rate = 0, resistance = 0) : RestorableParam(max_value, current_value, restore_rate) constructor {
	self.take_damage = function(value) {
		var damage = value * (1 - resistance);
		var difference = self.current - damage;
		self.decrease(damage);
		return difference < 0 ? difference : 0; 
	}
}

/// @description Constructor for speed params of an entity
/// @param {real} max_value
/// @param {real} acceleration
/// @param {real} resistance
function SpeedParam(max_value, acceleration = 0, resistance = 0) : BaseParam(max_value, 0) constructor {
	self.acceleration = acceleration;
	self.resistance = resistance;
	
	self.increase = function(value) {
		if value != 0 {
			self.current = self.current + (value * self.max - self.current) * self.acceleration * (1 - self.resistance);
		}
	}
	
	self.life_cycle = function() {
		self.current = self.current * (1 - self.resistance);
	}
	
	self.copy = function() {
		return new SpeedParam(self.max, self.acceleration, self.resistance);
	}
}
