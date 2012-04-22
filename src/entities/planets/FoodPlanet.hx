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
	private var power : Int;
	private var timer : Float;

	public function new(p_angle : Float, p_radius : Float, p_sun : Sun)
	{
		super(p_angle, p_radius, 20, p_sun);

		graphic = new Image("gfx/planets/food.png");
		power = 0;
		timer = 0;
	}

	public override function update() : Void
	{
		super.update();

		timer += HXP.elapsed;
		// trace("Timer: " + timer);
		if (timer > delay * (3 - power)) {
			trace("Reset and launch food");
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
		if (!collideRect(x, y, 90, 0, HXP.width - 90, HXP.height)) {
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