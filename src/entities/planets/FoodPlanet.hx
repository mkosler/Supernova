package entities.planets;

// Library imports
import com.haxepunk.graphics.Image;

// Game imports
import entities.planets.Planet;
import entities.planets.Sun;
import entities.planets.Orbit;

class FoodPlanet extends Planet 
{
	public function new(p_angle : Float, p_radius : Float, p_sun : Sun)
	{
		super(p_angle, p_radius, 20, p_sun);

		graphic = new Image("gfx/planets/food.png");
	}
}