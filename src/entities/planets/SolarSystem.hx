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
	static public inline var maxDelay : Float = 2.0;
	private var countTilNextWave : Int;
	private var startCount : Int;

	// Sun stuff
	public var sun : Sun;
	private var health : Int;
	private var healthBar : HealthBar;

	public function new(p_health : Int, p_numOrbits : Int)
	{
		entities = new Array<Entity>();
		timer = 0;
		wave = 0;
		delay = maxDelay;
		countTilNextWave = 10 * (wave + 1);
		startCount = countTilNextWave;

		sun = new Sun(p_health);
		entities.push(sun);
		
		while (p_numOrbits > 0) {
			entities.push(new Orbit(sun, p_numOrbits, p_numOrbits * 2));
			p_numOrbits--;
		}
	}

	public function update() : Void 
	{
		timer += HXP.elapsed;
		if (countTilNextWave <= 0) {
			countTilNextWave = 10 * (++wave + 1);
			startCount = countTilNextWave;
			delay = maxDelay;
		}
		if (timer >= delay * (5 - wave)) {
			trace("Incoming enemy!");
			timer = 0;
			delay = Math.max(0, delay - 0.1);
			if (HXP.random < 0.15 && (countTilNextWave / startCount) < 0.75) {
				HXP.world.add(new MotherShip(this));
			} else {
				HXP.world.add(new SimpleShip(sun));
			}
			trace("New delay: " + delay);
			countTilNextWave--;
		}
	}
}