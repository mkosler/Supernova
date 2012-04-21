package entities.planets;

// Library imports
import com.haxepunk.graphics.Image;

// Game imports
import entities.planets.Planet;
import entities.planets.Sun;
import entities.planets.Orbit;

class FoodPlanet extends Planet 
{
	public function new(p_x : Float, p_y : Float, p_sun : Sun)
	{
		super(p_x, p_y, 20, p_sun);

		graphic = new Image("gfx/planets/food.png");
	}
}