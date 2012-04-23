package worlds;

// Library imports
import com.haxepunk.World;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.graphics.Text;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

// Game imports
import worlds.GameWorld;
import ui.Button;

class TutWorld extends World 
{
	private var pages : Array<Entity>;
	public var pageNum : Int;
	private var buttons : Array<Button>;

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

		var buttonHeight : Int = HXP.height - 75;
		add(new Button(104, buttonHeight, new Image("gfx/buttons/play.png"), playCallback));
		add(new Button(104 + 128 + 104, buttonHeight, new Image("gfx/buttons/prev.png"), prevCallback));
		add(new Button(104 + 128 + 104 + 128 + 104, buttonHeight, new Image("gfx/buttons/tutorial.png"), nextCallback));
	}

	public function nextCallback() : Void
	{
		trace("Inside nextCallback");
		pageNum = Std.int(Math.min(pageNum + 1, pages.length - 1));
		makeVisible(pageNum);
	}

	public function prevCallback() : Void 
	{
		trace("Inside prevCallback");
		pageNum = Std.int(Math.max(pageNum - 1, 0));
		makeVisible(pageNum);
	}

	public function playCallback() : Void 
	{
		trace("Inside playCallback");
		HXP.world = new GameWorld();
	}

	public function returnCallback() : Void
	{
		trace("Inside returnCallback");
		pageNum = 0;
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
}