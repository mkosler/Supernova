package entities.planets;

// Library imports
import com.haxepunk.Entity;
import com.haxepunk.masks.Circle;
import com.haxepunk.graphics.TiledSpritemap;
import com.haxepunk.HXP;

// Game imports
import entities.ships.Bullet;
import entities.ships.Ship;

class Sun extends Entity 
{
	private var tiledSpritemap : TiledSpritemap;
	public var gravity : Float;
	public var health : Int;
	private var maxHealth : Int;

	public function new(p_health : Int)
	{
		super();

		tiledSpritemap = new TiledSpritemap("gfx/planets/sun.png", 64, 64);
		tiledSpritemap.add("normal", [0, 1], 1);
		graphic = tiledSpritemap;
		x = HXP.halfWidth - 32;
		y = HXP.halfHeight - 32;
		mask = new Circle(32, 32, 32);
		type = "planet";
		health = p_health;
		maxHealth = p_health;
	}

	public override function update() : Void 
	{
		super.update();

		tiledSpritemap.play("normal");

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

	public function upgrade() : Bool
	{
		if (health < maxHealth) {
			health += 5;
			return true;
		}
		return false;
	}
}