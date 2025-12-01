ship_health = new VitalParam(100, 100, 0, 0.2);
ship_shield = new VitalParam(100, 100, 5, 0.3);
ship_energy = new RestorableParam(100, 100, 10);
ship_movement_speed = new SpeedParam(10, 0.07, 0.05)
ship_rotation_speed = new SpeedParam(5, 0.07, 0.05)
gun_rotation_speed = new SpeedParam(5, 0.07, 0.05)

gun_id = instance_create_layer(x, y, "Instances", ObjTurret);
gun_id.gun = new Gun(
	10,
	gun_rotation_speed,
	id, 
	ObjBullet
)
gun_id.depth = depth - 1;

ship = new Spaceship(
	ship_health,
	ship_shield,
	ship_energy,
	ship_movement_speed,
	ship_rotation_speed,
	gun_id
);
ship.set_transform(x, y, direction);
ship.set_space_resistance(0.05);
