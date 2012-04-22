package entities.ships;

// Library imports
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

// Game imports
import entities.ships.Ship;

class Bullet extends Entity 
{
	private var targetX : Float;
	private var targetY : Float;
	public var damageValue : Int;
	static public inline var speed : Float = 5.0;

	public function new(p_ship : Ship, p_targetX : Int, p_targetY : Int)
	{
		super(p_ship.centerX, p_ship.centerY, new Image("gfx/bullet.png"));

		setHitbox(3, 3);
		type = "bullet";
		damageValue = p_ship.damageValue;
	}

	public override function update() : Void
	{
		super.update();

		moveTowards(targetX, targetY, speed, "planet", true);
	}

	public override function moveCollideX(e : Entity) : Void
	{
		HXP.world.remove(this);
	}

	public override function moveCollideY(e : Entity) : Void
	{
		HXP.world.remove(this);
	}
}