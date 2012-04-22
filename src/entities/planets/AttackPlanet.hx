package entities.planets;

// Library imports
import com.haxepunk.graphics.Image;
import com.haxepunk.Entity;
import com.haxepunk.HXP;

// Game imports
import entities.planets.Planet;
import entities.planets.Sun;
import entities.planets.Orbit;
import entities.ships.Ship;

class AttackPlanet extends Planet 
{
	static public inline var delay : Float = 3.5;
	private var timer : Float;
	private var canLaunch : Bool;

	public function new(p_angle : Float, p_radius : Float, p_sun : Sun)
	{
		super(p_angle, p_radius, 10, 0.75, p_sun);

		graphic = new Image("gfx/planets/attack.png");
		timer = 0;
		canLaunch = false;
	}

	public override function update() : Void 
	{
		super.update();

		if (paused) return;

		timer += HXP.elapsed;
		if (canLaunch || timer >= delay * (3 - power)) {
			canLaunch = true;
			var collideObj : Entity = HXP.world.nearestToEntity("ship", this, true);
			if (collideObj != null) {
				canLaunch = false;
				timer = 0;
				HXP.world.add(new Missile(x, y, collideObj, sun));
			}
		}
	}
}

private class Missile extends Entity 
{
	static public inline var speed : Float = 3.0;
	private var target : Entity;
	private var sun : Sun;

	public function new(p_x : Float, p_y : Float, p_target : Entity, p_sun : Sun)
	{
		super(p_x, p_y, new Image("gfx/missile.png"));

		setHitbox(5, 10);
		type = "missile";
		target = p_target;
		sun = p_sun;
	}

	public override function update() : Void
	{
		super.update();

		moveTowards(target.x, target.y, speed, "ship");
		if (sun.x <= target.x && target.x <= sun.x + sun.width && sun.y <= target.y && target.y <= sun.y + sun.height) {
			HXP.world.remove(this);
		}
	}

	public override function moveCollideX(e : Entity) : Void 
	{
		var ship : Ship = cast(e, Ship);
		ship.health--;
		HXP.world.remove(this);
	}

	public override function moveCollideY(e : Entity) : Void
	{
		var ship : Ship = cast(e, Ship);
		ship.health--;
		HXP.world.remove(this);
	}
}