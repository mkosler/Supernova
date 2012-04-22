package entities.planets;

// Library imports
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.HXP;

// Game imports
import entities.planets.Planet;
import entities.planets.Sun;
import entities.planets.Orbit;
import ui.Cursor;

class FoodPlanet extends Planet 
{
	static public inline var delay : Float = 2.5;
	static public inline var harvestAmount : Int = 5;
	private var timer : Float;

	public function new(p_angle : Float, p_radius : Float, p_sun : Sun)
	{
		super(p_angle, p_radius, 20, 1.5, p_sun);

		graphic = new Image("gfx/planets/food.png");
		timer = 0;
	}

	public override function update() : Void
	{
		super.update();

		if (paused) return;

		timer += HXP.elapsed;
		if (timer > delay * (3 - power)) {
			timer = 0;
			HXP.world.add(new Food(this, harvestAmount * (power + 1)));
		}
	}
}

private class Food extends Entity
{
	static public inline var maxSpeed : Float = 2;
	private var value : Int;
	private var speedX : Float;
	private var speedY : Float;
	private var image : Image;

	public function new(p_planet : FoodPlanet, p_value : Int)
	{
		super();

		trace("Making new food");

		x = p_planet.x;
		y = p_planet.y;
		image = new Image("gfx/resource.png");
		graphic = image;
		setHitbox(image.width, image.height);
		value = p_value;
		var sign : Int;
		if (HXP.random < 0.5) {
			sign = 1;
		} else {
			sign = -1;
		}
		speedX = maxSpeed * HXP.random * sign;
		speedY = maxSpeed * HXP.random * sign;
		layer = 9;
	}

	public override function update() : Void 
	{
		super.update();

		moveBy(speedX, speedY, "cursor");
		if (!collideRect(x, y, 0, 0, HXP.width, HXP.height)) {
			trace("Removing lost food");
			HXP.world.remove(this);
		}
	}

	public override function moveCollideX(e : Entity) : Void
	{
		var cursor : Cursor = cast(e, Cursor);
		cursor.collect(value);
		HXP.world.remove(this);
	}

	public override function moveCollideY(e : Entity) : Void
	{
		var cursor : Cursor = cast(e, Cursor);
		cursor.collect(value);
		HXP.world.remove(this);
	}
}