package entities.ships;

// Library imports
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Circle;
import com.haxepunk.HXP;

// Game imports
import entities.planets.Sun;

class Ship extends Entity 
{
	private var speedX : Float;
	private var speedY : Float;
	private var sun : Sun;
	private var health : Int;
	public var damageValue : Int;
	private var timer : Float;
	private var radius : Int;

	public function new(p_x : Float, p_y : Float, p_image : Image, p_speedX : Float, p_speedY : Float, p_sun : Sun, ?p_health : Int = 1, ?p_damageValue = 1)
	{
		super();

		x = p_x;
		y = p_y;
		graphic = p_image;
		radius = Std.int(p_image.width / 2);
		trace("Radius of ship: " + radius);

		// FUCK YOU CIRCLE MASK!
		// mask = new Circle(radius, radius, radius);

		// I love you hitbox!
		setHitbox(p_image.width, p_image.height);
		type = "ship";
		speedX = p_speedX * HXP.random;
		speedY = p_speedY * HXP.random;
		sun = p_sun;
		health = p_health;
		damageValue = p_damageValue;
	}

	public override function update() : Void
	{
		super.update();

		timer += HXP.elapsed;
		var collideObj : Entity = collideTypes(["planet", "missile", "cursor"], x, y);
		HXP.console.log([x, y, width, height, Std.string(collideObj != null)]);
		if (collideObj != null) {
			trace("Ship hit!");
			health--;
			if (health <= 0) {
				trace("Ship destroyed!");
				HXP.world.remove(this);
			}
		}
	}
}