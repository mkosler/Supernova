package ui;

// Library imports
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Text;

// Game imports
import entities.planets.Sun;
import entities.planets.Planet;
import entities.planets.FoodPlanet;
import entities.planets.AttackPlanet;
import entities.planets.DefendPlanet;

class PlanetButton extends Entity
{
	private var image : Image;
	public var name : String;
	public var sun : Sun;
	public var cost : Int;
	static public inline var scale : Int = 3;
	private var text : Text;

	public function new(p_x : Float, p_y : Float, p_image : Image, p_name : String, p_cost : Int, p_sun : Sun)
	{
		super(p_x, p_y);

		image = p_image;
		image.scale = scale;
		graphic = image;
		name = p_name;
		type = "button";
		layer = 0;
		sun = p_sun;
		cost = p_cost;
		setHitbox(image.scaledWidth, image.scaleHeight);
	}

	public override function update() : Void 
	{
		super.update();
	}
}