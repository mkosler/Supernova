package entities.planets;

// Library imports
import com.haxepunk.graphics.Image;
import com.haxepunk.Entity;
import com.haxepunk.HXP;

// Game imports
import entities.planets.Planet;
import entities.planets.Sun;
import entities.planets.Orbit;

class AttackPlanet extends Planet 
{
	static public inline var delay : Float = 2.5;
	private var timer : Float;

	public function new(p_angle : Float, p_radius : Float, p_sun : Sun)
	{
		super(p_angle, p_radius, 10, 2.5, p_sun);

		graphic = new Image("gfx/planets/attack.png");
		timer = 0;
	}

	public override function update() : Void 
	{
		super.update();

		if (paused) return;

		timer += HXP.elapsed;
		if (timer >= delay * (3 - power)) {
			timer = 0;
			var collideObj : Entity = HXP.world.nearestToEntity("ship", this, true);
			if (collideObj != null) {
				HXP.world.add(new Missile(x, y, collideObj.x, collideObj.y));
			}
		}
	}
}

private class Missile extends Entity 
{
	static public inline var speed : Float = 3.0;
	private var targetX : Float;
	private var targetY : Float;

	public function new(p_x : Float, p_y : Float, p_targetX : Float, p_targetY : Float)
	{
		super(p_x, p_y, new Image("gfx/missile.png"));

		setHitbox(5, 10);
		type = "missile";
		targetX = p_targetX;
		targetY = p_targetY;
	}

	public override function update() : Void
	{
		super.update();

		moveTowards(targetX, targetY, speed, "ship");
	}

	public override function moveCollideX(e : Entity) : Void 
	{
		HXP.world.remove(this);
	}

	public override function moveCollideY(e : Entity) : Void
	{
		HXP.world.remove(this);
	}
}