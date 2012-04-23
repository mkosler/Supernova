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
import entities.planets.FoodPlanet;
import entities.planets.AttackPlanet;
import entities.planets.DefendPlanet;
import entities.HealthBar;

class GameWorld extends World 
{
	public var solarSystem : SolarSystem;
	public var cursor : Cursor;
	private var foodButton : PlanetButton;
	private var foodText : Text;
	private var attackButton : PlanetButton;
	private var attackText : Text;
	private var defendButton : PlanetButton;
	private var defendText : Text;
	private var upgradeButton : PlanetButton;
	private var upgradeText : Text;
	private var resourceText : Text;
	private var foodPlanetText : Text;
	private var attackPlanetText : Text;
	private var defendPlanetText : Text;
	private var waveText : Text;
	private var paused : Bool;

	public function new()
	{
		super();
	}

	public override function begin() : Void
	{
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
		addGraphic(foodText = new Text("FOOD\n" + costString + foodButton.cost), 0, foodButton.x - 10, foodButton.y + foodButton.height + 10);

		attackButton = cast(add(new PlanetButton(25, 200, new Image("gfx/planets/attack.png"), "attack", 20, solarSystem.sun)), PlanetButton);
		addGraphic(attackText = new Text("ATT\n" + costString + attackButton.cost), 0, attackButton.x - 10, attackButton.y + attackButton.height + 10);

		defendButton = cast(add(new PlanetButton(25, 300, new Image("gfx/planets/defend.png"), "defend", 20, solarSystem.sun)), PlanetButton);
		addGraphic(defendText = new Text("DEF\n" + costString + defendButton.cost), 0, defendButton.x - 10, defendButton.y + defendButton.height + 10);

		upgradeButton = cast(add(new PlanetButton(25, 400, new Image("gfx/upgrade.png"), "upgrade", 35, solarSystem.sun)), PlanetButton);
		addGraphic(upgradeText = new Text("UP\n" + costString + upgradeButton.cost), 0, upgradeButton.x - 10, upgradeButton.y + upgradeButton.height + 10);

		cursor = new Cursor();
		add(cursor);
		addGraphic(resourceText = new Text("Food " + cursor.totalResources), 0, plateRight.x + 10, 100);

		// slightly less ugly
		var foodPlanetImage : Image = new Image("gfx/planets/food.png");
		foodPlanetImage.scale = 3;
		addGraphic(foodPlanetImage, 0, plateRight.x + 10, 200);

		addGraphic(foodPlanetText = new Text(" "), 0, plateRight.x + 10, 250);

		var attackPlanetImage : Image = new Image("gfx/planets/attack.png");
		attackPlanetImage.scale = 3;
		addGraphic(attackPlanetImage, 0, plateRight.x + 10, 300);

		addGraphic(attackPlanetText = new Text(" "), 0, plateRight.x + 10, 350);

		var defendPlanetImage : Image = new Image("gfx/planets/defend.png");
		defendPlanetImage.scale = 3;
		addGraphic(defendPlanetImage, 0, plateRight.x + 10, 400);

		addGraphic(defendPlanetText = new Text(" "), 0, plateRight.x + 10, 450);

		addGraphic((waveText = new Text("WAVE: " + Std.string(solarSystem.wave + 1))), 0, plateRight.x + 10, 50);
		// /end ugly

		Input.define("Pause", [Key.P, Key.SPACE]);
		paused = false;
	}

	public override function update() : Void 
	{
		super.update();

		solarSystem.update();

		if (solarSystem.sun.health <= 0) {
			HXP.world = new TutWorld();
		}

		resourceText.text = "Food " + cursor.totalResources;
		// var label : Text = cast(resourceText.graphic, Text);
		// label.text = "Food " + cursor.totalResources;

		// OH GOD ITS SO UGLY
		var foodPlanets : Array<Entity> = new Array<Entity>();
		getClass(FoodPlanet, foodPlanets);
		foodPlanetText.text = Std.string(foodPlanets.length);

		var attackPlanets : Array<Entity> = new Array<Entity>();
		getClass(AttackPlanet, attackPlanets);
		attackPlanetText.text = Std.string(attackPlanets.length);		

		var defendPlanets : Array<Entity> = new Array<Entity>();
		getClass(DefendPlanet, defendPlanets);
		defendPlanetText.text = Std.string(defendPlanets.length);

		foodText.text = "FOOD\nCost: " + Std.string(foodButton.cost);
		attackText.text = "ATT\nCost: " + Std.string(attackButton.cost);
		defendText.text = "DEF\nCost: " + Std.string(defendButton.cost);
		waveText.text = "WAVE: " + Std.string(solarSystem.wave + 1);

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

	public override function add(e : Entity) : Entity
	{
		if (e.type == "planet") {
			add(new HealthBar(e));
		}

		return super.add(e);
	}

	public override function remove(e : Entity) 
	{
		if (e.type == "planet") {
			var healthBars : Array<Entity> = new Array<Entity>();
			getType("health", healthBars);
			for (item in healthBars) {
				var hp : HealthBar = cast(item, HealthBar);
				if (hp.attachedSun == e || hp.attachedPlanet == e) {
					remove(hp);
					break;
				}
			}
		}

		return super.remove(e);	
	}
}