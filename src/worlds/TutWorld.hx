package worlds;

// Library imports
import com.haxepunk.World;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Input;
import com.haxepunk.HXP;
import com.haxepunk.Entity;

// Game imports
import worlds.GameWorld;

class TutWorld extends World 
{
	private var pages : Array<Entity>;
	public var pageNum : Int;

	public function new()
	{
		super();

		pages = new Array<Entity>();
		pages.push(addGraphic(new Backdrop("gfx/title.png")));
		pages[0].visible = true;
		pages.push(addGraphic(new Backdrop("gfx/tutorial/tutpage1.png")));
		pages[1].visible = false;
		pages.push(addGraphic(new Backdrop("gfx/tutorial/tutpage2.png")));
		pages[2].visible = false;

		pageNum = 0;

		add(new TextButton(HXP.width / 4, HXP.height - 75, new Text("PREV"), prevCallback));
		add(new TextButton(HXP.width * 3 / 4, HXP.height - 75, new Text("NEXT"), nextCallback));
	}

	public override function begin() : Void
	{

	}

	public function nextCallback() : Void
	{
		trace("Inside nextCallback");
		pageNum++;
		makeVisible(pageNum);
	}

	public function prevCallback() : Void 
	{
		trace("Inside prevCallback");
		pageNum = Std.int(Math.min(--pageNum, 0));
		makeVisible(pageNum);
	}

	public function makeVisible(p_num : Int) : Void
	{
		for (i in 0...pages.length) {
			if (i == p_num) {
				pages[i].visible = true;
			} else {
				pages[i].visible = false;
			}
		}
	}

	public override function update() : Void
	{
		super.update();

		if (pageNum >= pages.length) {
			trace("Starting game");
			HXP.world = new GameWorld();
		}
	}
}

private class TextButton extends Entity 
{
	private var calling : Void -> Void;

	public function new(p_x : Float, p_y : Float, p_text : Text, p_callback : Void -> Void)
	{
		super(p_x, p_y, p_text);

		setHitbox(p_text.width, p_text.height);
		calling = p_callback;
	}

	public override function update() : Void
	{
		if (Input.mousePressed && collidePoint(x, y, Input.mouseX, Input.mouseY)) {
			trace("Hitting button");
			calling();
		}
	}
}