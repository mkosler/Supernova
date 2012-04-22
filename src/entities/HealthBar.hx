package entities;

// Library imports
import com.haxepunk.Entity;
import com.haxepunk.utils.Draw;

// Game imports
import entities.planets.Planet;
import entities.planets.Sun;

class HealthBar extends Entity 
{
	// Ugly, hack way to get sun and planets
	private var attachedPlanet : Planet;
	private var attachedSun : Sun;
	private var health : Int;

	public function new(p_entity : Entity)
	{
		super(p_entity.x - 5, p_entity.y - 5);

		health = 0;

		// I feel so dirty
		if (Std.is(p_entity, Sun)) {
			attachedSun = cast(p_entity, Sun);
			attachedPlanet = null;
		} else {
			attachedSun = null;
			attachedPlanet = cast(p_entity, Planet);
		}
	}

	public override function update() : Void 
	{
		// /shivers
		health = attachedSun != null ? attachedSun.health : attachedPlanet.health;
		x = attachedSun != null ? attachedSun.x + (attachedSun.width / 2) - (health / 2) : attachedPlanet.x + (attachedPlanet.width / 2) - (health / 2);
		y = attachedSun != null ? attachedSun.y - 10 : attachedPlanet.y - 10;
	}

	public override function render() : Void
	{
		super.render();

		Draw.line(Std.int(x), Std.int(y), Std.int(x + health), Std.int(y), 0x00FF00);
	}
}