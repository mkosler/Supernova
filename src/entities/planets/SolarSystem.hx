package entities.planets;

// Library imports
import com.haxepunk.Entity;
import com.haxepunk.masks.Circle;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

// Game imports
import entities.planets.Sun;
import entities.planets.Orbit;
import entities.HealthBar;

class SolarSystem 
{
	// Hacking my way to SUCCESS! Add all entities to this array, then simply add them inside GameWorld
	public var entities : Array<Entity>;

	// Sun stuff
	public var sun : Sun;
	private var health : Int;

	// Orbit stuff
	// private var orbits : Array<Orbit>;

	public function new(p_health : Int, p_numOrbits : Int)
	{
		entities = new Array<Entity>();

		sun = new Sun(p_health);
		addPlanetoid(sun);

		// orbits = new Array<Orbit>();
		for (i in 0...p_numOrbits) {
			addOrbit(new Orbit(sun, i + 1, (i + 1) * 2));
		}
	}

	private function addPlanetoid(e : Entity) : Void
	{
		entities.push(e);
		entities.push(new HealthBar(e));
	}

	private function addOrbit(o : Orbit) : Void 
	{
		entities.push(o);
	}
}