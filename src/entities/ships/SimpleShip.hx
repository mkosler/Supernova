package entities.ships;

// Library imports
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

// Game imports
import entities.ships.Ship;
import entities.ships.Bullet;
import entities.planets.Sun;

class SimpleShip extends Ship 
{
	public function new(p_x : Float, p_y : Float, p_speedX : Float, p_speedY : Float, p_sun : Sun)
	{
		super(p_x, p_y, new Image("gfx/simpleship.png"), p_speedX, p_speedY, p_sun, 1, 1, 1.75);
	}

	public override function update() : Void 
	{
		super.update();

		// var newSpeedX = speedX * HXP.random;
		// var newSpeedY = speedY * HXP.random;
		// if (x < sun.centerX) {
		// 	x += newSpeedX;
		// } else {
		// 	x -= newSpeedX;
		// }
		// if (y < sun.centerY) {
		// 	y += newSpeedY;
		// } else {
		// 	y -= newSpeedY;
		// }
		// if (x == sun.centerX || y == sun.centerY) {
		// 	if (speedX < speedY) {
		// 		speedX = speedY;
		// 	} else {
		// 		speedY = speedX;
		// 	}
		// }
		moveTowards(sun.centerX, sun.centerY, speedX);
		// trace("Ship timer: " + timer);
		// if (timer >= delay) {
		// 	trace("Enemy fire!");
		// 	timer = 0;
		// 	var target : Entity = HXP.world.nearestToEntity("planet", this, true);
		// 	if (target != null) {
		// 		HXP.world.add(new Bullet(this, Std.int(target.centerX), Std.int(target.centerY)));
		// 	}
		// }
	}
}