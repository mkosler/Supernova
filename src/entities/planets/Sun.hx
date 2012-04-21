package entities.planets;

// Library imports
import com.haxepunk.Entity;
import com.haxepunk.masks.Circle;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

// Game imports

class Sun extends Entity 
{
	public var gravity : Float;
	private var sunWell : SunWell;
	private var health : Int;
	private var numOrbits : Int;

	// Health bar stuff
	private var health_image : Image;
	static public inline var damageColorFlip = 0x001111;

	public function new(p_x : Float, p_y : Float, p_grav : Float, p_health : Int, p_numOrbits : Int, p_wellRadius : Int = 64)
	{
		super(p_x, p_y, new Image("gfx/planets/sun.png"));

		mask = new Circle(32, Std.int(p_x), Std.int(p_y));
		type = "sun";
		setOrigin(Std.int(p_x + (width / 2)), Std.int(p_y + (height / 2)));
		sunWell = new SunWell(originX, originY, p_wellRadius);
		health = p_health;
		numOrbits = p_numOrbits;
	}

	public override function update() : Void 
	{
		super.update();

		var collideObj : Entity = collideTypes(["bullet", "ship"], x, y);
		if (collideObj != null) {
			// Do stuff
		}
	}
}

private class SunWell extends Entity
{
	public function new(p_x : Float, p_y : Float, p_wellRadius : Int)
	{
		super(p_x, p_y);
		mask = new Circle(p_wellRadius, Std.int(p_x), Std.int(p_y));
		type = "well";
	}
}