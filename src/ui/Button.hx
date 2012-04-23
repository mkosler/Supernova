package ui;

// Library import
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Input;

// Game import

class Button extends Entity 
{
	private var calling : Void -> Void;

	public function new(p_x : Float, p_y : Float, p_image : Image, p_callback : Void->Void)
	{
		super(p_x, p_y, p_image);

		setHitbox(p_image.width, p_image.height);
		calling = p_callback;
	}

	public override function update() : Void
	{
		super.update();

		if (Input.mousePressed && collidePoint(x, y, Input.mouseX, Input.mouseY)) {
			calling();
		}
	}
}