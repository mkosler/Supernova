package entities.planets;

// Library imports
import com.haxepunk.Entity;
import com.haxepunk.masks.Circle;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

// Game imports
import entities.ships.Bullet;
import entities.ships.Ship;

class Sun extends Entity 
{
	public var gravity : Float;
	public var health : Int;

	// Health bar stuff
	private var health_image : Image;
	static public inline var damageColorFlip = 0x001111;

	public function new(p_health : Int)
	{
		super();

		var image : Image = new Image("gfx/planets/sun.png");
		graphic = image;
		x = HXP.halfWidth - (image.width / 2);
		y = HXP.halfHeight - (image.height / 2);
		mask = new Circle(32, 32, 32);
		type = "planet";
		health = p_health;
	}

	public override function update() : Void 
	{
		super.update();

		var collideObj : Entity = collideTypes(["bullet", "ship"], x, y);
		if (collideObj != null) {
			trace("Sun has been hit!");
			if (collideObj.type == "ship") {
				var ship : Ship = cast(collideObj, Ship);
				health -= ship.damageValue;
			} else if (collideObj.type == "bullet") {
				var bullet : Bullet = cast(collideObj, Bullet);
				health -= bullet.damageValue;
			}
		}
	}
}