package entities.planets;

// Library imports
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.Entity;

// Game imports
import entities.planets.Planet;
import entities.planets.Sun;
import entities.planets.Orbit;

class DefendPlanet extends Planet 
{
	static public inline var gravityLength : Float = 25;
	static public inline var pullPercentage : Float = 0.10;

	public function new(p_angle : Float, p_radius : Float, p_sun : Sun)
	{
		super(p_angle, p_radius, 40, 0.75, p_sun);

		graphic = new Image("gfx/planets/defend.png");
	}

	public override function update() : Void 
	{
		super.update();

		if (paused) return;


		var collideObj : Entity = HXP.world.nearestToEntity("ship", this, true);
		if (collideObj != null && distanceFrom(collideObj) < gravityLength * (3 - power)) {
			var dX : Float = (collideObj.x - x) * (power + 1) * pullPercentage;
			var dY : Float = (collideObj.y - y) * (power + 1) * pullPercentage;
			collideObj.x += dX;
			collideObj.y += dY;
		}
	}
}