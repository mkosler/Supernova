package entities.planets;

// Library imports
import com.haxepunk.graphics.Image;

// Game imports
import entities.planets.Planet;
import entities.planets.Sun;
import entities.planets.Orbit;

class AttackPlanet extends Planet 
{
	public function new(p_x : Float, p_y : Float)
	{
		super(p_x, p_y, 10);

		graphic = new Image("gfx/planets/attack.png");
	}
}