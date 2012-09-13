package  
{
	/**
	 * ...
	 * @author Jose
	 */
	
	import org.flixel.*;
	
	public class TestState extends FlxState
	{
		//class to load the image for the tile maps
		[Embed(source = '/assets/tiles/ground(16x16).png')] private var GroundGraphic:Class;
		
		//TileMap CSV Class
		[Embed(source = '/assets/tileMap/mapCSV_Group1_Map1.csv' , mimeType = "application/octet-stream")] private var Map1CSV:Class;
		
		//Group for tileMap pool for dynamic world creation.
		private var group1:FlxGroup;
		
		//Group for sprite pool for dynamic obstacle creation.
		private var group2:FlxGroup;
		
		//TileMaps that will be added to the group
		private var tileMap1:FlxTilemap;
		private var tileMap2:FlxTilemap;
		
		//TileMaps that will be added to the State, properties will be extracted from pool
		private var randomMap1:FlxTilemap;
		private var randomMap2:FlxTilemap;
		
		//Control variable for world creation
		private var added: Boolean;
		
		//uint Array to store posible y axis of obstacles;
		private var obstacleHeight:Array;
		
		//Text to display distance
		private var text:FlxText;
		
		//Text to Display Controls
		private var infoText:FlxText;
		
		//Distace travelled by player
		private var distance:uint;
		
		//Player
		private var plyer:Player;
		
		//Enemy Spider
		private var fullSpider:FullSpider;	
		
		//Boxes' Debris
		private var boxDebris:BoxDebris;
		
		//Auxiliar var to control Slide actions
		private var auxSlide:Number;
		
		//Sky background
		public var sky:Sky;
		
		//Minions group
		private var minions:Minions;
		
		override public function create():void {	
			
			//******************INITIALIZATIONS******************
			//Groups creations
			group1 = new FlxGroup(); //TODO Use more descriptive names for this objects
			group2 = new FlxGroup();
			
			obstacleHeight = new Array();
			
			//Pushing possible heights for obstacles
			obstacleHeight.push(164);
			obstacleHeight.push(153);
			obstacleHeight.push(142);			
			
			tileMap1 = new FlxTilemap(); //TODO Use more descriptive names for this objects
			tileMap2 = new FlxTilemap();
			
			randomMap1 = new FlxTilemap(); //TODO Use more descriptive names for this objects
			randomMap2 = new FlxTilemap();			
			
			//Starting texts
			text = new FlxText(20, 20, 200);
			infoText = new FlxText(200, 20, 200, "Press C to Jump and X to Slide");
			
			//Loading tileMaps
			tileMap1.loadMap(new Map1CSV, GroundGraphic, 16, 16);
			tileMap2.loadMap(new Map1CSV, GroundGraphic, 16, 16);
			
			//Starting tiles to have the same value on every game and keep layer order
			randomMap1 = tileMap1;
			randomMap2 = tileMap2;
			
			//Starting control value to false as no generated tile has been added
			added = false;
			
			//Player creation
			plyer = new Player(randomMap1.x + 100, 160-15);
			
			//Enemy creation
			fullSpider = new FullSpider( -100, 50);
			
			//Boxes' debris creation, ready to be exploded
			boxDebris = new BoxDebris(0,0);
			
			//Sky creation
			sky = new Sky();
			
			//Minions enemies creation
			minions = new Minions(fullSpider.spider,15);
			
			//******************ADDS******************
			//Adding the Sky background
			add(sky);
			
			//Adding tiles to pool
			group1.add(tileMap1);
			group1.add(tileMap2);
			
			//Creating and adding new obstacles to pool
			group2.add(new RedBox(randomMap1.x + 300, 164));
			group2.add(new RedBox(randomMap1.x + 420, 147));
			group2.add(new RedBox(randomMap1.x + 520, 164));
			group2.add(new RedBox(randomMap1.x + 640, 164));
			
			//Adding initial elements to state
			add(randomMap1);
			add(randomMap2);
			add(text);
			add(infoText);
			add(plyer);
			add(group2);
			add(boxDebris);
			add(minions);
			add(fullSpider);
			
			//******************MISC******************
			//Setting auxSlide
			auxSlide = Math.floor(plyer.height/2);
			
			//Setting text static on screen
			infoText.scrollFactor.x = 0;
			infoText.scrollFactor.y = 0;
			text.scrollFactor.x = 0;
			text.scrollFactor.y = 0;
			
			//Setting initial distance
			distance = 0;
		}
		
		override public function update():void {			
			
			//Collitions
			FlxG.collide(plyer, randomMap1);
			FlxG.collide(plyer, randomMap2);
			FlxG.collide(group2, randomMap1);
			FlxG.collide(group2, randomMap2);
			FlxG.collide(boxDebris, randomMap1);
			FlxG.collide(boxDebris, randomMap2);
			FlxG.collide(minions, randomMap1);
			FlxG.collide(minions, randomMap2);
			
			//Setting camera bounds to increase as the player through the map
			FlxG.camera.setBounds(0, 0, 300 + plyer.x, randomMap1.height);
			
			//Setting camere style to platformer and to always follow the player
			FlxG.camera.follow(plyer, FlxCamera.STYLE_PLATFORMER);
			
			//Setting the world bounds to be the double of the first tile map to make the generated tileMaps Solid
			FlxG.worldBounds = new FlxRect(0, 0, randomMap1.x + 1280, 304);
			
			//Player acceleration rate
			plyer.acceleration.x = plyer.maxVelocity.x * 8;	
			
			//enemy acceleration rate
			fullSpider.spider.acceleration.x = fullSpider.spider.maxVelocity.x * 8;
			
			//Default movement-values for "minion"
			minions.callAll("eject",true);	
			
			//calculating distance traveled with function calculatePlayerDistance
			distance = calculatePlayerDistance(plyer);
			
			//refreshing text to always show current distance
			text.text = "Distance = " + distance.toString() + " Meters";
			
			//this if generates a tile map ahead of the player when he reaches half of
			//the first tileMap, it checks the control variable added so it wont keep
			//building tiles
			if (plyer.x >= (randomMap1.x + 300) && !added) {
				randomMap2 = generateTileMap(randomMap1);
				add(randomMap2);
				added = true;
			}
				
			//this if generates a tile map ahead of the player when he reaches half of
			//the second tileMap, this new tileMap will become the first tileMap to create loop
			//it checks the control variable added so it wont keep
			//building tiles	
			else if (plyer.x >= (randomMap2.x + 300) && added) {
				randomMap1 = generateTileMap(randomMap2);
				add(randomMap1);
				added = false;
			}	
				
			//Controls setup
			if(FlxG.keys.X) {
				plyer.height = auxSlide;
				plyer.width = 26;
				plyer.offset.y = 5;
				plyer.offset.x = -5;
				
				if(FlxG.keys.justPressed("X")){
					plyer.y += auxSlide;
					plyer.x -= auxSlide;
					plyer.play("Crapping");
					plyer.angle = -90;
				}
			} else {
				plyer.height = 30;
				plyer.width = 13;
				plyer.offset.y = 0;
				plyer.offset.x = 0;
				
				if(FlxG.keys.justReleased("X")){
					plyer.y -= auxSlide;
					plyer.x += auxSlide;
					plyer.angle = 0;
				}				
				plyer.play("Run");
			}
			
			if(FlxG.keys.justPressed("C") && plyer.isTouching(FlxObject.FLOOR)){
				plyer.velocity.y = -plyer.maxVelocity.y/2;	
				plyer.play("Jump");
			}	
			
			if(FlxG.keys.justPressed("Z")){
				minions.launch();
			}	
				
			//this if controls that the obstacles group is not greater than 100
			//to avoid lag in game
			//call method to generate a new obstacle in reference to last obstacle in group
			//then it adds it to the group			
			if (group2.length <= 100) {
				group2.add(generateObstacles(group2.members[group2.length - 1]));
			}
				
			//this if keeps deleting the obstacles so group will never be to big
			//and cause lag in game
			//it always deletes the first object in group
			else if (group2.length > 50 && group2.length <  52) {				
				var obstacle:RedBox = group2.members[0];
				group2.remove(obstacle, true);
			}	
			
			//overlaping objects and functions
			FlxG.overlap(plyer, fullSpider, hitSpider);	
			FlxG.overlap(plyer, group2,hitObj);
			FlxG.overlap(plyer, minions, hitObj);
			FlxG.overlap(fullSpider.spider, group2, destroyBox);	
			FlxG.overlap(fullSpider.spider, minions, returnMinion);
			
			super.update();			
		}
		
		//this function gets a reference tile map and assigns it to its local variable
		//while the local variable is the same as the reference tile map
		//it will keep picking a tile map randomly from the group pool
		//This is to prevent 2 tiles being the same in a row
		//if they are different the local variable will become the picked tile map
		//and be sent to positionTileMap function for positioning relative to the reference tile map
		//then it will be returned
		public function generateTileMap(referenceTileMap:FlxTilemap):FlxTilemap {			
			var tileMap:FlxTilemap;
			tileMap = referenceTileMap;
			
			while (tileMap == referenceTileMap)	{
				var assigner:Number = (Math.ceil(Math.random() * group1.length))-1;
				tileMap = group1.members[assigner]; 			
			}
			
			positionTileMap(referenceTileMap, tileMap);
			return tileMap;					
		}	
		
		//this function gets a reference obstacle
		//it creates a new one and positions it relative to the reference obstacle
		public function generateObstacles(referenceObstacle:RedBox):RedBox {			
			var obstacle:RedBox;
			
			obstacle = new RedBox(0, 0);
			positionObstacle(referenceObstacle, obstacle);
			
			return obstacle;			
		}
		
		//positions the picked tile map from group to always be ahead of the reference tile map
		public function positionTileMap(referenceTileMap:FlxTilemap, tileMapToPosition:FlxTilemap):void {			
			tileMapToPosition.reset(referenceTileMap.width + referenceTileMap.x,referenceTileMap.y);			
		}
		
		// positions the new obstacle to always be ahead of reference obstacle and pick a height from group
		public function positionObstacle(referenceObstacle:RedBox, obstacle:RedBox):void {			
			var betweenDistanceY :uint;
			var betweenDistanceX :uint = (Math.ceil(Math.random() * 20)) + 100;
			betweenDistanceY = (Math.ceil(Math.random() * obstacleHeight.length)) -1;
			betweenDistanceY = obstacleHeight[betweenDistanceY];
			obstacle.reset(referenceObstacle.x + betweenDistanceX , betweenDistanceY);			
		}
		
		//reduces the player accelaration to and plays hurt animation
		public function deacceleration():void {			
			plyer.acceleration.x = 0;
			plyer.play("Hurt");
		}
		
		// calculates the distance traveled by player, it make every 20 pixels 1 meter
		public function calculatePlayerDistance(playerToCalculate:Player):uint {			
			var runnedDistance:uint = playerToCalculate.x / 20;
			return runnedDistance;
		}
		
		//function executed when player overlaps an obstacle
		//flickers the obstacle and reduces player speed
		public function hitObj(plyer:FlxObject, object:FlxObject):void {			
			object.flicker();
			deacceleration();
		}
		
		//function executed when spider overlaps an obstacle
		//destroy the obstacle and explode into particles
		public function destroyBox(spider:FlxObject, box:FlxObject):void
		{
			boxDebris.x = box.x+box.width/2;
			boxDebris.y = box.y;
			boxDebris.start(true,5);
			
			box.kill();
		}
		
		//function executed when spider overlaps a minion
		//destroy the minion so it can be reused
		public function returnMinion(spider:FlxObject, minion:FlxObject):void
		{
			if(minion.x < spider.x+spider.width/2){
				minion.kill();
			}
		}	
		
		//it calls new GameOver State
		public function callOverState():void {			
			FlxG.switchState(new GameOverState);
		}
		
		//function executed when player overlaps a enemy
		//fades screen out, then it changes to game over state
		public function hitSpider(plyer:FlxObject, spider:FlxObject):void {			
			FlxG.fade(0xff000000, 1, callOverState, false);			
		}							
	}
}

