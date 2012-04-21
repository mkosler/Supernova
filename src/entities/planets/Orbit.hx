package entities.planets;

// Library imports
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

// Game imports
import entities.planets.Sun;
import entities.planets.Planet;

class Orbit extends Entity 
{
	private var image : Image;
	public var numPlanetsHeld : Int;
	private var maxPlanets : Int;
	public var radius : Float;
	private var sun : Sun;
	private var size : Int;

	public function new(p_sun : Sun, p_size : Int, p_maxPlanets : Int)
	{
		super();

		numPlanetsHeld = 0;
		size = Std.int(Math.min(Math.max(p_size, 0), 3));
		image = new Image("gfx/planets/orbit" + size + ".png");
		graphic = image;
		maxPlanets = p_maxPlanets;
		x = p_sun.originX - (image.width / 2);
		y = p_sun.originY - (image.height / 2);
		setOrigin(p_sun.originX, p_sun.originY);
		radius = distanceToPoint(Std.int(p_sun.originX), Std.int(p_sun.originY));
	}

	public function addPlanet(p_planet : Planet) : Bool
	{
		if (numPlanetsHeld < maxPlanets) {
			numPlanetsHeld++;
			return true;
		} else {
			return false;
		}
	}
}