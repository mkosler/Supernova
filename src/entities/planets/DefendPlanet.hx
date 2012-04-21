package entities.planets;

// Library imports
import com.haxepunk.graphics.Image;

// Game imports
import entities.planets.Planet;
import entities.planets.Sun;
import entities.planets.Orbit;

class DefendPlanet extends Planet 
{
	public function new(p_x : Float, p_y : Float, p_rotSpeed : Float, p_sun : Sun, p_currentOrbit : Orbit, p_angle : Int)
	{
		super(p_x, p_y, 40, p_rotSpeed, p_sun, p_currentOrbit, p_angle);

		graphic = new Image("gfx/planets/defend.png");
	}
}