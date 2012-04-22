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
import entities.ships.SimpleShip;
import entities.ships.MotherShip;

class SolarSystem 
{
	// Hacking my way to SUCCESS! Add all entities to this array, then simply add them inside GameWorld
	public var entities : Array<Entity>;

	private var timer : Float;
	public var wave : Int;
	private var delay : Float;
	private var countTilNextWave : Int;

	// Sun stuff
	public var sun : Sun;
	private var health : Int;
	private var healthBar : HealthBar;

	public function new(p_health : Int, p_numOrbits : Int)
	{
		entities = new Array<Entity>();
		timer = 0;
		wave = 0;
		delay = 2.0;
		countTilNextWave = 10 * (wave + 1);

		sun = new Sun(p_health);
		health = p_health;
		addPlanetoid(sun);

		// orbits = new Array<Orbit>();

		while (p_numOrbits > 0) {
			addOrbit(new Orbit(sun, p_numOrbits, p_numOrbits * 2));
			p_numOrbits--;
		}
	}

	private function addPlanetoid(e : Entity) : Void
	{
		entities.push(e);
		entities.push((healthBar = new HealthBar(e)));
	}

	private function addOrbit(o : Orbit) : Void 
	{
		entities.push(o);
	}

	public function update() : Void 
	{
		timer += HXP.elapsed;

		// MORE UGLY...JUST WORK DAMN IT!
		// healthBar.applyDamage(health - sun.health);
		// health = sun.health;

		if (timer >= delay * (5 - wave)) {
			trace("Incoming enemy!");
			timer = 0;
			delay = Math.max(0.4, delay - 0.1);
			if (HXP.random < 0.05) {
				HXP.world.add(new MotherShip(this));
			} else {
				HXP.world.add(new SimpleShip(sun));
			}
			trace("New delay: " + delay);
		}
	}
}