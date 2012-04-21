package ui;

// Library imports
import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

// Game imports
import ui.PlanetButton;
import entities.planets.Orbit;

class Cursor extends Entity
{
	// static public inline var foodPlanetImage : Image = new Image("gfx/planets/food.png");
	// static public inline var attackPlanetImage : Image = new Image("gfx/planets/attack.png");
	// static public inline var defendPlanetImage : Image = new Image("gfx/planets/defend.png");
	private var foodPlanetImage : Image;
	private var attackPlanetImage : Image;
	private var defendPlanetImage : Image;
	private var occupied : Bool;
	private var name : String;
	static public inline var size : Int = 16;

	public function new()
	{
		super();

		foodPlanetImage = new Image("gfx/planets/food.png");
		attackPlanetImage = new Image("gfx/planets/attack.png");
		defendPlanetImage = new Image("gfx/planets/defend.png");
		x = Input.mouseX;
		y = Input.mouseY;
		occupied = false;
		name = null;
		setHitbox(size, size);
	}

	public override function update() : Void 
	{
		super.update();

		x = Input.mouseX;
		y = Input.mouseY;

		var collideObj : Entity = collideTypes(["button", "orbit"], x, y);
		if (collideObj != null && Input.mousePressed) {
			switch (collideObj.type) {
			case "button":
				if (!occupied) {
					var button : PlanetButton = cast(collideObj, PlanetButton);
					name = button.name;
					graphic = pullGraphic(name);
					occupied = true;
				}
			case "orbit":
				if (occupied) {
					var orbit : Orbit = cast(collideObj, Orbit);
					var angle : Float = HXP.angle(x, y, orbit.x, orbit.y);
					trace("New angle: " + angle);
					if (orbit.addPlanet(name, angle)) {
						graphic = null;
						name = null;
						occupied = false;
					}
				}
			}
		}
	}

	private function pullGraphic(p_name : String) : Image
	{
		switch (p_name) {
		case "food":
			return foodPlanetImage;
		case "attack":
			return attackPlanetImage;
		case "defend":
			return defendPlanetImage;
		default:
			return null;
		}
	}
}