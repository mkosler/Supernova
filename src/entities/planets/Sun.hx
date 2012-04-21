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
	private var health : Int;

	// Health bar stuff
	private var health_image : Image;
	static public inline var damageColorFlip = 0x001111;

	public function new(p_health : Int)
	{
		var image : Image = new Image("gfx/planets/sun.png");
		super(HXP.halfWidth - (image.width / 2), HXP.halfHeight - (image.height / 2), image);

		mask = new Circle(32, Std.int(x), Std.int(y));
		type = "sun";
		setOrigin(Std.int(x + (width / 2)), Std.int(y + (height / 2)));
		health = p_health;
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

// private class SunWell extends Entity
// {
// 	public function new(p_x : Float, p_y : Float, p_wellRadius : Int)
// 	{
// 		super(p_x, p_y);
// 		mask = new Circle(p_wellRadius, Std.int(p_x), Std.int(p_y));
// 		type = "well";
// 	}
// }