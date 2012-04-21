package;

// Library imports
import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.utils.Key;

// Game imports
import worlds.GameWorld;

class Main extends Engine
{

	public static inline var kScreenWidth:Int = 800;
	public static inline var kScreenHeight:Int = 600;
	public static inline var kFrameRate:Int = 60;
	public static inline var kClearColor:Int = 0x333333;
	public static inline var kProjectName:String = "HaxePunk";

	public function new()
	{
		super(kScreenWidth, kScreenHeight, kFrameRate, false);
	}

	override public function init()
	{
		HXP.console.enable();
		HXP.console.toggleKey = Key.TAB;

		HXP.screen.color = kClearColor;
		HXP.screen.scale = 1;
		HXP.world = new GameWorld();
	}

	public static function main()
	{
		new Main();
	}

}