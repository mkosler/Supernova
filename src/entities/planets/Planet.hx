package entities.planets;

// Library imports
import com.haxepunk.Entity;
import com.haxepunk.masks.Circle;
import com.haxepunk.HXP;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;

// Game imports
import entities.planets.Sun;
import entities.planets.Orbit;

class Planet extends Entity 
{
	private var isHeld : Bool;

	public var health : Int;
	private var rotSpeed : Float;
	public var level : Int;
	private var sun : Sun;
	public var radius : Float;
	private var angle : Float;

	// public function new(p_x : Float, p_y : Float, p_health : Int, p_rotSpeed : Float, p_sun : Sun, p_currentOrbit : Orbit, p_angle : Int)
	public function new(p_x : Float, p_y : Float, p_health : Int, p_sun : Sun)
	{
		super(p_x, p_y);

		isHeld = true;
		mask = new Circle(8, 8, 8);
		type = "planet";
		health = p_health;
		level = 1;
		sun = p_sun;
	}

	public override function update() : Void 
	{
		super.update();

		if (isHeld) {
			x = Input.mouseX;
			y = Input.mouseY;
			if (Input.mousePressed) {
				var collideObjs : Array<Entity> = new Array<Entity>();
				collideInto("orbit", x, y, collideObjs);
				trace("Attempting to place planet : " + collideObjs.length);
				if (collideObjs.length > 0) {
					var orbit : Orbit = cast(collideObjs[collideObjs.length - 1], Orbit);
					if (orbit.addPlanet(this)) {
						trace("Toggling held");
						isHeld = false;
					}
				}
			}
		} else {
			var radians : Float = angle * (Math.PI / 180);
			x = sun.centerX + (radius * Math.cos(radians));
			y = sun.centerY + (radius * Math.sin(radians));

			angle += rotSpeed;
			angle %= 360;

			var collideObj : Entity = collideTypes(["bullet", "ship"], x, y);
			if (collideObj != null) {
				// Do stuff
			}
		}
	}
}