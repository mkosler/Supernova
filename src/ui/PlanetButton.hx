package ui;

// Library imports
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.HXP;

// Game imports
import entities.planets.Planet;
import entities.planets.FoodPlanet;
import entities.planets.AttackPlanet;
import entities.planets.DefendPlanet;

class PlanetButton extends Entity 
{
	private var image : Image;

	public function new(p_x : Float, p_y : Float, p_image : Image, p_cost : Int)
	{
		super(p_x, p_y);

		image = p_image;
		graphic = image;
		type = "button";
		setHitbox(image.width, image.height);
	}

	public function mouseClick()
	{
		if (within(Input.mouseX, x, width) && within(Input.mouseY, y, height) && Input.mousePressed) {

		}
	}

	private function within(value : Float, lower : Float, upper : Float)  : Bool
	{
		return lower <= value && value <= upper;
	}

	private function pullPlanet() : Planet
	{
		switch (image.name) {
			case "food":
				return new FoodPlanet(Input.mouseX, Input.mouseY)
			case "attack":
			case "defend":
		}
	}
}