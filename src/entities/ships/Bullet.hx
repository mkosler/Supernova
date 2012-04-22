package entities.ships;

// Library imports
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

// Game imports
import entities.ships.Ship;

class Bullet extends Entity 
{
	private var speedX : Float;
	private var speedY : Float;
	public var damageValue : Int;

	public function new(p_ship : Ship, p_targetX : Int, p_targetY : Int)
	{
		super(p_ship.centerX, p_ship.centerY, new Image("gfx/bullet.png"));

		setHitbox(3, 3);
		type = "bullet";
		var a : Float = angle(p_targetX, p_targetY, x, y);
		speedX = 5 * Math.cos(a);
		speedY = 5 * Math.sin(a);
		damageValue = p_ship.damageValue;
	}

	public override function update() : Void
	{
		super.update();

		moveBy(speedX, speedY, "planet");
		if (!collideRect(x, y, 0, 0, HXP.width, HXP.height)) {
			trace("Removing lost bullet");
			HXP.world.remove(this);
		}
	}

	public override function moveCollideX(e : Entity) : Void
	{
		HXP.world.remove(this);
	}

	public override function moveCollideY(e : Entity) : Void
	{
		HXP.world.remove(this);
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