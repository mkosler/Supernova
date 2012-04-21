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
	private var radius : Float;
	private var angle : Float;

	// public function new(p_x : Float, p_y : Float, p_health : Int, p_rotSpeed : Float, p_sun : Sun, p_currentOrbit : Orbit, p_angle : Int)
	public function new(p_x : Float, p_y : Float, p_health : Int)
	{
		super(p_x, p_y);

		isHeld = true;

		mask = new Circle(16, Std.int(p_x), Std.int(p_y));
		type = "planet";
		setOrigin(Std.int(p_x + 8), Std.int(p_y + 8));

		health = p_health;
		// rotSpeed = p_rotSpeed;
		level = 1;
		// radius = p_currentOrbit.radius;
		// angle = p_angle;
		// sun = p_sun;
	}

	public override function update() : Void 
	{
		super.update();

		if (isHeld) {
			x = Input.mouseX;
			y = Input.mouseY;
		} else {
			var radians : Float = angle * (Math.PI / 180);
			x = sun.originX + (radius * Math.cos(radians));
			y = sun.originY + (radius * Math.sin(radians));

			angle += rotSpeed;
			angle %= 360;

			var collideObj : Entity = collideTypes(["bullet", "ship"], x, y);
			if (collideObj != null) {
				// Do stuff
			}
		}
	}
}