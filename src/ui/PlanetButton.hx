package ui;

// Library imports
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.HXP;

// Game imports
import entities.planets.Sun;
import entities.planets.Planet;
import entities.planets.FoodPlanet;
import entities.planets.AttackPlanet;
import entities.planets.DefendPlanet;

class PlanetButton extends Entity 
{
	private var image : Image;
	private var name : String;
	public var sun : Sun;
	public var occupied : Bool;

	public function new(p_x : Float, p_y : Float, p_image : Image, p_name : String, p_cost : Int, p_sun : Sun)
	{
		super(p_x, p_y);

		image = p_image;
		image.scale = 3;
		graphic = image;
		name = p_name;
		type = "button";
		sun = p_sun;
		setHitbox(image.scaledWidth, image.scaleHeight);
		occupied = false;
	}

	public override function update() : Void 
	{
		super.update();

		if (collidePoint(x, y, Input.mouseX, Input.mouseY)) {
			if (Input.mousePressed && !occupied) {
				trace("Pulling planet");
				HXP.world.add(pullPlanet());
				occupied = true;
			}
		}
	}

	private function pullPlanet() : Planet
	{
		switch (name) {
			case "food":
				return new FoodPlanet(Input.mouseX, Input.mouseY, sun);
			case "attack":
				return new AttackPlanet(Input.mouseX, Input.mouseY, sun);
			case "defend":
				return new DefendPlanet(Input.mouseX, Input.mouseY, sun);
			default:
				return null;
		}
	}
}