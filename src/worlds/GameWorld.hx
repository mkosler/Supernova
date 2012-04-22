package worlds;

// Library imports
import com.haxepunk.World;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Backdrop;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Text;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Key;

// Game imports
import ui.PlanetButton;
import ui.Cursor;
import entities.planets.SolarSystem;
import entities.planets.Sun;

class GameWorld extends World 
{
	public var solarSystem : SolarSystem;
	public var cursor : Cursor;
	private var foodButton : PlanetButton;
	private var foodText : Entity;
	private var attackButton : PlanetButton;
	private var attackText : Entity;
	private var defendButton : PlanetButton;
	private var defendText : Entity;
	private var upgradeButton : PlanetButton;
	private var upgradeText : Entity;
	private var resourceText : Entity;
	private var paused : Bool;

	public function new()
	{
		super();

		addGraphic(new Backdrop("gfx/background.png"));

		solarSystem = new SolarSystem(100, 3);
		for (e in solarSystem.entities) {
			add(e);
		}

		// UI plates
		var plateLeft : Entity = addGraphic(new Image("gfx/plate.png"));
		var plateRight : Entity = addGraphic(new Image("gfx/plate.png"));

		plateLeft.x = -10;
		plateLeft.y = 0;
		plateLeft.layer = 0;

		plateRight.x = HXP.width - 90;
		plateRight.y = 0;
		plateRight.layer = 0;

		// Ugliest thing I have ever done
		var costString : String = "Cost: ";
		foodButton = cast(add(new PlanetButton(25, 100, new Image("gfx/planets/food.png"), "food", 20, solarSystem.sun)), PlanetButton);
		foodText = addGraphic(new Text(costString + foodButton.cost));
		foodText.x = foodButton.x - 10;
		foodText.y = foodButton.y + foodButton.height + 10;
		foodText.layer = 0;

		attackButton = cast(add(new PlanetButton(25, 200, new Image("gfx/planets/attack.png"), "attack", 20, solarSystem.sun)), PlanetButton);
		attackText = addGraphic(new Text(costString + attackButton.cost));
		attackText.x = attackButton.x - 10;
		attackText.y = attackButton.y + attackButton.height + 10;
		attackText.layer = 0;

		defendButton = cast(add(new PlanetButton(25, 300, new Image("gfx/planets/defend.png"), "defend", 20, solarSystem.sun)), PlanetButton);
		defendText = addGraphic(new Text(costString + defendButton.cost));
		defendText.x = defendButton.x - 10;
		defendText.y = defendButton.y + defendButton.height + 10;
		defendText.layer = 0;

		upgradeButton = cast(add(new PlanetButton(25, 400, new Image("gfx/upgrade.png"), "upgrade", 35, solarSystem.sun)), PlanetButton);
		upgradeText = addGraphic(new Text(costString + upgradeButton.cost));
		upgradeText.x = upgradeButton.x - 10;
		upgradeText.y = upgradeButton.y + upgradeButton.height + 10;
		upgradeText.layer = 0;
		// /end ugly

		cursor = new Cursor();
		add(cursor);
		resourceText = addGraphic(new Text("Total food:\n" + cursor.totalResources));
		resourceText.x = plateRight.x + 10;
		resourceText.y = 100;
		resourceText.layer = 0;

		Input.define("Pause", [Key.P, Key.SPACE]);
		paused = false;
	}

	public override function update() : Void 
	{
		super.update();

		solarSystem.update();

		var label : Text = cast(resourceText.graphic, Text);
		label.text = "Food " + cursor.totalResources;

		if (Input.pressed("Pause")) {
			paused = !paused;
			trace("Pressed pause: " + Std.string(paused));
			var entities : Array<Entity> = new Array<Entity>();
			getType("planet", entities);
			for (e in entities) {
				e.paused = paused;
			}
		}
	}
}