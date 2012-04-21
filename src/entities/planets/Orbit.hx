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

		sun = p_sun;
		numPlanetsHeld = 0;
		size = Std.int(Math.min(Math.max(p_size, 0), 5));
		maxPlanets = p_maxPlanets;
		x = sun.centerX - ((baseSize * p_size) / 2);
		y = sun.centerY - ((baseSize * p_size) / 2);
		radius = sun.centerX - x;
		trace("Orbit size[" + size + "].radius = " + radius);
		HXP.console.log([x, sun.centerX]);
		type = "orbit";
		mask = new Circle(Std.int(radius), Std.int(radius), Std.int(radius));
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
		Draw.circle(Std.int(sun.centerX), Std.int(sun.centerY), Std.int(radius), 0xFFFFFF);
	}
}