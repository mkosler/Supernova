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
import entities.planets.FoodPlanet;
import entities.planets.AttackPlanet;
import entities.planets.DefendPlanet;

class Orbit extends Entity 
{
	public var numPlanetsHeld : Int;
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
		x = sun.centerX - ((baseSize * p_size) / 2);
		y = sun.centerY - ((baseSize * p_size) / 2);
		radius = sun.centerX - x;
		type = "orbit";
		mask = new Circle(Std.int(radius), Std.int(radius), Std.int(radius));
	}

	public function addPlanet(p_name : String, p_angle : Float) : Bool
	{
		trace("Pulling planet: " + p_name);
		numPlanetsHeld++;
		var planet : Planet = pullPlanet(p_name, p_angle);
		HXP.world.add(planet);
		return true;
	}

	private function pullPlanet(p_name : String, p_angle : Float) : Planet
	{
		switch (p_name) {
		case "food":
			trace("Found planet " + p_name);
			return new FoodPlanet(p_angle, radius, sun);
		case "attack":
			return new AttackPlanet(p_angle, radius, sun);
		case "defend":
			return new DefendPlanet(p_angle, radius, sun);
		default:
			return null;
		}
	}

	public override function render() : Void 
	{
		super.render();

		Draw.circle(Std.int(sun.centerX), Std.int(sun.centerY), Std.int(radius), 0xEEEEEE);
	}
}