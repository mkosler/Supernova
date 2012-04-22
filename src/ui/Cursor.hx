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
import entities.planets.Sun;

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

		// Hacking my way to SUCCESS!
		var collideObj : Entity = collide("planet", x, y);
		if (collideObj != null && Input.mousePressed && occupied && name == "upgrade") {
			if (Std.is(collideObj, Sun)) {
				var sun : Sun = cast(collideObj, Sun);
				if (sun.upgrade()) {
					totalResources -= heldValue;
					graphic = null;
					name = null;
					occupied = false;
				}
			} else {
				var planet : Planet = cast(collideObj, Planet);
				if (planet.upgrade()) {
					totalResources -= heldValue;
					graphic = null;
					name = null;
					occupied = false;
				}
			}
		}

		collideObj = collideTypes(["button", "orbit"], x, y);
		if (collideObj != null && Input.mousePressed) {
			switch (collideObj.type) {
			case "button":
				trace("Clicking on button");
				var button : PlanetButton = cast(collideObj, PlanetButton);
				if (button.cost <= totalResources) {
					heldValue = button.cost;
					name = button.name;
					graphic = pullGraphic(name);
					occupied = true;
				}
			// case "planet":
			// 	trace("Clicking on planet");
			// 	if (occupied && name == "upgrade") {
			// 		var planet : Planet = cast(collideObj, Planet);
			// 		if (planet.power < 3) {
			// 			planet.power++;
			// 			totalResources -= heldValue;
			// 			graphic = null;
			// 			name = null;
			// 			occupied = false;
			// 		}
			// 	}
			case "orbit":
				trace("Clicking on orbit");
				if (occupied && name != "upgrade") {
					var orbit : Orbit = cast(collideObj, Orbit);
					var angle : Float = angle(x, y, HXP.halfWidth, HXP.halfHeight) * 180 / Math.PI;
					HXP.console.log([x, y, HXP.halfWidth, HXP.halfHeight, angle]);
					if (orbit.addPlanet(name, angle)) {
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

	private function angle(p_x : Float, p_y : Float, p_baseX : Float, p_baseY : Float) : Float
	{
		var a : Float = Math.atan((p_y - p_baseY) / (p_x - p_baseX));
		if (p_x <= p_baseX) {
			return Math.PI + a;
		} else {
			return ((2 * Math.PI) + a) % (2 * Math.PI);
		}
	}
}