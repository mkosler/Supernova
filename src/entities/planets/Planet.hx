package entities.planets;

// Library imports
import com.haxepunk.Entity;
import com.haxepunk.masks.Circle;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;

// Game imports
import entities.planets.Sun;
import entities.planets.Orbit;
import entities.ships.Ship;
import entities.ships.Bullet;

class Planet extends Entity 
{
	private var isHeld : Bool;

	public var health : Int;
	private var rotSpeed : Float;
	public var level : Int;
	private var sun : Sun;
	public var radius : Float;
	private var angle : Float;
	public var power : Int;

	// public function new(p_x : Float, p_y : Float, p_health : Int, p_rotSpeed : Float, p_sun : Sun, p_currentOrbit : Orbit, p_angle : Int)
	public function new(p_angle : Float, p_radius : Float, p_health : Int, p_rotSpeed : Float, p_sun : Sun)
	{
		super();

		isHeld = true;
		mask = new Circle(8, 8, 8);
		type = "planet";
		health = p_health;
		level = 1;
		angle = p_angle;
		radius = p_radius;
		sun = p_sun;
		power = 0;
		rotSpeed = p_rotSpeed;
	}

	public override function update() : Void 
	{
		super.update();

		if (paused) return;

		var radians : Float = angle * (Math.PI / 180);
		x = sun.centerX + (radius * Math.cos(radians));
		y = sun.centerY + (radius * Math.sin(radians));
		angle += rotSpeed;
		angle %= 360;

		// var collideObj : Entity = collide("bullet", x, y);
		var collideObj : Entity = collideTypes(["bullet", "ship"], x, y);
		if (collideObj != null) {
			if (collideObj.type == "ship") {
				health--;
			} else if (collideObj.type == "bullet") {
				var bullet : Bullet = cast(collideObj, Bullet);
				health -= bullet.damageValue;
			}
		}
	}
}