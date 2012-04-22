package entities.ships;

// Library imports
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.masks.Circle;
import com.haxepunk.HXP;

// Game imports
import entities.planets.Sun;
import entities.ships.Bullet;

class Ship extends Entity 
{
	private var speedX : Float;
	private var speedY : Float;
	private var sun : Sun;
	public var health : Int;
	public var damageValue : Int;
	private var timer : Float;
	private var radius : Int;
	private var delay : Float;

	public function new(p_image : Image, p_speedX : Float, p_speedY : Float, p_sun : Sun, ?p_health : Int = 1, ?p_damageValue = 1, p_delay : Float)
	{
		super();

		if (HXP.random < 0.5) {
			// Do stuff
			if (HXP.random < 0.5) {
				x = 0;
			} else {
				x = HXP.width;
			}
			y = HXP.height * HXP.random;
		} else {
			// Do other stuff
			if (HXP.random < 0.5) {
				y = 0;
			} else {
				y = HXP.height;
			}
			x = HXP.width * HXP.random;
		}
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
		timer = 0;
		delay = p_delay;
	}

	public override function update() : Void
	{
		super.update();

		timer += HXP.elapsed;
		if (health <= 0) {
			trace("Ship destroyed!");
			HXP.world.remove(this);
		}
		var collideObj : Entity = collideTypes(["planet", "missile"], x, y);
		if (collideObj != null) {
			trace("Ship hit!");
			health--;
		}
		if (timer >= delay) {
			trace("Enemy fire!");
			timer = 0;
			var target : Entity = HXP.world.nearestToEntity("planet", this, true);
			if (target != null) {
				HXP.world.add(new Bullet(this, Std.int(target.centerX), Std.int(target.centerY)));
			}
		}
	}
}