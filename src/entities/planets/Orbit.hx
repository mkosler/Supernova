package entities.planets;

// Library imports
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;
import com.haxepunk.masks.Circle;
import com.haxepunk.utils.Draw;

// Game imports
import entities.planets.Sun;
import entities.planets.Planet;

class Orbit extends Entity 
{
	public var numPlanetsHeld : Int;
	private var maxPlanets : Int;
	public var radius : Float;
	private var sun : Sun;
	private var size : Int;
	static public inline var baseSize : Int = 128;

	public function new(p_sun : Sun, p_size : Int, p_maxPlanets : Int)
	{
		super();

		numPlanetsHeld = 0;
		size = Std.int(Math.min(Math.max(p_size, 0), 5));
		maxPlanets = p_maxPlanets;
		x = p_sun.originX - ((baseSize * p_size) / 2);
		y = p_sun.originY - ((baseSize * p_size) / 2);
		setOrigin(p_sun.originX, p_sun.originY);
		radius = distanceToPoint(Std.int(p_sun.originX), Std.int(p_sun.originY));
		type = "orbit";
		var circle : Circle = new Circle(Std.int(radius), p_sun.originX, p_sun.originY);
		mask = circle;
		trace("Sun origin (" + p_sun.originX + ", " + p_sun.originY + ")");
		trace("Mask position (" + circle.x + ", " + circle.y + ")");
		sun = p_sun;
	}

	public function addPlanet(p_planet : Planet) : Bool
	{
		if (numPlanetsHeld < maxPlanets) {
			numPlanetsHeld++;
			p_planet.radius = radius;
			return true;
		} else {
			return false;
		}
	}

	public override function render() : Void 
	{
		super.render();

		Draw.resetTarget();
		Draw.circle(sun.originX, sun.originY, Std.int(radius), 0xFFFFFF);
	}
}