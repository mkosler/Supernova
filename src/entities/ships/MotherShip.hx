package entities.ships;

// Library imports
import com.haxepunk.HXP;

// Game imports
import entities.ship.Ship;
import entities.planets.SolarSystem;
import entities.planets.Orbit;

class MotherShip extends Ship 
{
	private var isAdvancing : Bool;

	public function new(p_x : Float, p_y : Float, p_speedX : Float, p_speedY : Float, p_solarSystem : SolarSystem)
	{
		super(p_x, p_y, new Image("gfx/mothership.png"), 1.5, 2.0, p_solarSystem.sun, 5, 3, 1.4);

		isAdvancing = false;
	}

	public override function update() : Void
	{
		super.update();

		var targetX : Float = sun.centerX;
		var targetY : Float = sun.centerY;
		var closeOrbit : Orbit = cast(HXP.world.nearestToEntity("orbit", this, true), Orbit);
		if (closeOrbit.numPlanetsHeld > 0) {
			if (distanceToPoint(sun.centerX. sun.centerY) < closeOrbit.radius + 30) {
				isAdvancing = false;
			}
		}
		if (isAdvancing) {
			moveTowards(targetX, targetY, speed);
		}
	}
}