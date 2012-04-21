package worlds;

// Library imports
import com.haxepunk.World;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.graphics.Image;

// Game imports
import entities.planets.Sun;
import entities.planets.FoodPlanet;
import entities.planets.AttackPlanet;
import entities.planets.DefendPlanet;
import entities.planets.Orbit;
import entities.HealthBar;

/// Used as a testing bed
class GameWorld extends World 
{
	public var sun : Sun;
	static public inline var tempSpeed = 2;
	private var tempOrbit : Orbit;
	private var tempFood : FoodPlanet;
	private var tempAttack : AttackPlanet;
	private var tempDefend : DefendPlanet;

	public function new()
	{
		super();

		addGraphic(new Backdrop("gfx/background.png"));

		sun = new Sun(HXP.halfWidth - 32, HXP.halfHeight - 32, 10, 100, 3, 64);
		add(sun);
		add(new HealthBar(sun));

		// TEMP TESTING
		tempOrbit = new Orbit(sun, 1, 10);
		add(tempOrbit);
		tempFood = new FoodPlanet(tempOrbit.x, HXP.halfHeight, 20, tempSpeed, sun, tempOrbit, 0);
		add(tempFood);
		add(new HealthBar(tempFood));
		tempAttack = new AttackPlanet(tempOrbit.x + tempOrbit.width, HXP.halfHeight, 10, tempSpeed, sun, tempOrbit, 90);
		add(tempAttack);
		add(new HealthBar(tempAttack));
		tempDefend = new DefendPlanet(tempOrbit.x + (tempOrbit.width / 2), HXP.halfHeight - (tempOrbit.height / 2), 40, tempSpeed, sun, tempOrbit, 180);
		add(tempDefend);
		add(new HealthBar(tempDefend));

		// UI plates
		var plateLeft : Entity = addGraphic(new Image("gfx/plate.png"));
		var plateRight : Entity = addGraphic(new Image("gfx/plate.png"));

		plateLeft.x = -10;
		plateLeft.y = 0;

		plateRight.x = HXP.width - 90;
		plateRight.y = 0;
	}

	public override function update() : Void 
	{
		super.update();
	}
}