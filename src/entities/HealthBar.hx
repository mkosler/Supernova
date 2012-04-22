package entities;

// Library imports
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.tweens.misc.ColorTween;

// Game imports

class HealthBar extends Entity 
{
	private var attachedEntity : Entity;
	private var image : Image;
	static public inline var damageColorFlip = 0x000001;

	public function new(p_entity : Entity)
	{
		super(p_entity.x - 5, p_entity.y - 5);

		image = new Image("gfx/healthbar.png");
		graphic = image;
		attachedEntity = p_entity;
	}

	public override function update() : Void 
	{
		x = attachedEntity.x + (attachedEntity.width / 2) - (image.width / 2);
		y = attachedEntity.y - 10;
	}

	public function applyDamage(p_damage : Float) 
	{
		if (p_damage <= 0) return;
		image.color -= Std.int(damageColorFlip * p_damage);
	}
}