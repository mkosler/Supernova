package ui;

// Library imports
import com.haxepunk.Entity;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

// Game imports
import ui.PlanetButton;
import entities.planets.Orbit;
import entities.planets.Planet;

class Cursor extends Entity
{
	private var foodPlanetImage : Image;
	private var attackPlanetImage : Image;
	private var defendPlanetImage : Image;
	private var upgradeImage : Image;
	private var occupied : Bool;
	private var name : String;
	private var heldValue : Int;
	public var totalResources : Int;
	static public inline var size : Int = 16;

	public function new()
	{
		super();

		foodPlanetImage = new Image("gfx/planets/food.png");
		attackPlanetImage = new Image("gfx/planets/attack.png");
		defendPlanetImage = new Image("gfx/planets/defend.png");
		upgradeImage = new Image("gfx/upgrade.png");
		x = Input.mouseX;
		y = Input.mouseY;
		occupied = false;
		name = null;
		type = "cursor";
		setHitbox(size, size);
		totalResources = 40;
		heldValue = 0;
		layer = 0;
	}

	public override function update() : Void 
	{
		super.update();

		x = Input.mouseX;
		y = Input.mouseY;

		if (Input.pressed(Key.ESCAPE)) {
			graphic = null;
			name = null;
			occupied = false;
		}

		var collideObj : Entity = collideTypes(["button", "orbit", "planet"], x, y);
		if (collideObj != null && Input.mousePressed) {
			switch (collideObj.type) {
			case "button":
				var button : PlanetButton = cast(collideObj, PlanetButton);
				if (button.cost <= totalResources) {
					heldValue = button.cost;
					name = button.name;
					graphic = pullGraphic(name);
					occupied = true;
				}
			case "orbit":
				if (occupied && name != "upgrade") {
					var orbit : Orbit = cast(collideObj, Orbit);
					var angle : Float = HXP.angle(x, y, orbit.x + orbit.width, orbit.y + (orbit.height / 2));
					trace("New angle: " + angle);
					if (orbit.addPlanet(name, angle)) {
						totalResources -= heldValue;
						graphic = null;
						name = null;
						occupied = false;
					}
				}
			case "planet":
				if (occupied && name == "upgrade") {
					var planet : Planet = cast(collideObj, Planet);
					if (planet.power < 3) {
						planet.power++;
						totalResources -= heldValue;
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
		case "upgrade":
			return upgradeImage;
		default:
			return null;
		}
	}

	public function collect(p_value : Int) : Void
	{
		totalResources += p_value;
	}
}