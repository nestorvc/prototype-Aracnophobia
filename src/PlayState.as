package
{
	/**
	 * ...
	 * @author Jose
	 */
	import mx.core.FlexSprite;
	
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.FlxCollision;
	
	public class PlayState extends FlxState
	{
		//Pool for the tileMaps and tile Maps to be added
		private var tileMapPool:FlxGroup;
		//tileMaps that will be assigned random values
		private var randomTileMap1:FlxTilemap;
		private var randomTileMap2:FlxTilemap;
		//tile map group that contains random tilemaps
		private var tileMapsOnScreen:FlxGroup;
		//Control variable for world creation
		private var added:Boolean;
		//Group for sprite pool for dynamic obstacle creation.
		private var obstacleSpriteGroup:FlxGroup;
		//
		private var web:Web;
		private var webGround:WebGround;
		//Text to display distance
		private var distanceText:FlxText;
		//Text to Display Controls
		private var infoText:FlxText;
		//Distace travelled by player
		private var distance:uint;
		//Player
		private var plyer:Player;
		//Enemy Spider
		private var fullSpider:FullSpider;	
		
		public function PlayState()
		{
		
		}
		
		override public function create():void
		{
			//******************INITIALIZATIONS******************
			
			tileMapPool = new FlxGroup();
			tileMapsOnScreen = new FlxGroup();
			obstacleSpriteGroup = new FlxGroup();
			randomTileMap1 = new LowGroundTileMap();
			randomTileMap2 = new LowGroundTileMap();			
			web = new Web(400, 160);
			webGround = new WebGround(800, 285);
			plyer = new Player(randomTileMap1.x + 100, 100,50);
			fullSpider = new FullSpider(-500, 130);
			distanceText = new FlxText(20, 20, 200);
			infoText = new FlxText(400, 20, 200, "X to jump C to slide");
			
			//******************ADDS******************
			tileMapPool.add(new LowGroundTileMap());
			tileMapPool.add(new LowGroundTileMap());
			obstacleSpriteGroup.add(web);
			obstacleSpriteGroup.add(webGround);
			obstacleSpriteGroup.add(new WebGround(1100, 285));
			obstacleSpriteGroup.add(new Web(1400, 160));
			tileMapsOnScreen.add(randomTileMap1);
			tileMapsOnScreen.add(randomTileMap2);
			
			add(tileMapsOnScreen);
			add(obstacleSpriteGroup);
			add(plyer.bullet.group);
			add(plyer);
			
			add(fullSpider);
			add(distanceText);
			add(infoText);
			
			//******************MISC******************
			FlxG.bgColor = 0xff000000;
			distance = 0;

			added = false;
			infoText.scrollFactor.x = 0;
			infoText.scrollFactor.y = 0;
			
			distanceText.scrollFactor.x = 0;
			distanceText.scrollFactor.y = 0;
			
			randomTileMap2.x -= randomTileMap1.width;			
			
			FlxG.watch(plyer.acceleration, "x", "Player AccX");
			FlxG.watch(fullSpider.spider.acceleration, "x", "Spider AccX");
			FlxG.watch(fullSpider.spider, "x", "Player CoordX");
			FlxG.watch(plyer, "height", "PLayer Height");
			FlxG.watch(plyer, "auxJump", "PLayer JumP");
		
		}
		
		override public function update():void
		{
			//Collisions
			FlxG.collide(tileMapsOnScreen, plyer);
			FlxG.collide(fullSpider, tileMapsOnScreen);
			
			//Setting camera bounds to increase as the player through the map
			FlxG.camera.setBounds(0, 0, 300 + plyer.x, 360);
			
			//Setting camere style to platformer and to always follow the player
			FlxG.camera.follow(plyer, FlxCamera.STYLE_PLATFORMER);
			
			//Setting the world bounds to be the double of the first tile map to make the generated tileMaps Solid
			FlxG.worldBounds = new FlxRect(0, 0, randomTileMap1.x + 3000, 360);
			
			//Playing bite Animation
			fullSpider.spider.play("Bite");
			
			//Player acceleration rate
			plyer.acceleration.x = plyer.maxVelocity.x * 8;
			
			//Enemy acceleration rate
			fullSpider.spider.acceleration.x = fullSpider.spider.maxVelocity.x * 8;

			//Calculating distance traveled with function calculatePlayerDistance
			distance = calculatePlayerDistance(plyer);
			
			//Refreshing text to always show current distance
			distanceText.text = "Distance = " + distance.toString() + " Meters";
			
			//Prepares the incoming tilemap for the player
			incomingTilemap();
						
			//Death trigger
			if (gameOverTrigger())
			{
				FlxG.switchState(new GameOverState);
			}
			
			//Overlaps
			FlxG.overlap(plyer, obstacleSpriteGroup, hitWeb);
			FlxG.overlap(plyer.bullet.group, fullSpider.minions, destroyMinion);
			
			//Distance to launch minions
			var distanceBetween:Number = plyer.x - fullSpider.spider.x;
			Minion.distance = distanceBetween;
			
			super.update();
			
			//Obstacles cleaning
			if (obstacleSpriteGroup.length >= 80)
			{
				obstacleSpriteGroup.remove(obstacleSpriteGroup.members[0], true);
			}
		
		}
		
		public function incomingTilemap():void
		{
			//this if generates a ground sprite ahead of the player when he reaches half of
			//the first ground sprite, it checks the control variable added so it wont keep
			//building sprites
			if (plyer.x >= (randomTileMap1.x + FlxG.width/2) && !added)
			{
				
				randomTileMap2 = generateTileMap(randomTileMap1);
				
				tileMapsOnScreen.add(randomTileMap2);
				
				obstacleSpriteGroup.add(generateObstacles(obstacleSpriteGroup.members[obstacleSpriteGroup.length - 1]));
				obstacleSpriteGroup.add(generateObstacles(obstacleSpriteGroup.members[obstacleSpriteGroup.length - 1]));
				obstacleSpriteGroup.add(generateObstacles(obstacleSpriteGroup.members[obstacleSpriteGroup.length - 1]));
				
				added = true;
			}
			
			//this if generates a ground sprite ahead of the player when he reaches half of
			//the second ground sprite, this new ground sprite will become the first ground sprite to create loop
			//it checks the control variable added so it wont keep
			//building sprites	
			if (plyer.x >= (randomTileMap2.x + FlxG.width/2) && added)
			{
				
				randomTileMap1 = generateTileMap(randomTileMap2);
				tileMapsOnScreen.add(randomTileMap1);
				
				obstacleSpriteGroup.add(generateObstacles(obstacleSpriteGroup.members[obstacleSpriteGroup.length - 1]));
				obstacleSpriteGroup.add(generateObstacles(obstacleSpriteGroup.members[obstacleSpriteGroup.length - 1]));
				obstacleSpriteGroup.add(generateObstacles(obstacleSpriteGroup.members[obstacleSpriteGroup.length - 1]));
				
				added = false;
			}
		}
			
		// calculates the distance traveled by player, it make every 20 pixels
		//1 meter
		public function calculatePlayerDistance(playerToCalculate:Player):uint
		{
			var runnedDistance:uint = playerToCalculate.x / 20;
			return runnedDistance;
		}
		
		/*
		 * This function generates tileMaps
		 * @param referenceTileMap, uses this to make sure the generated tile map it's not the same one the player is in and pases is to positionTileMap function
		 * @return FlxTileMap
		 * */
		public function generateTileMap(referenceTileMap:FlxTilemap):FlxTilemap
		{
			
			var newTileMap:FlxTilemap;
			
			newTileMap = referenceTileMap;
			while (newTileMap == referenceTileMap)
			{
				var assigner:Number = (Math.ceil(Math.random() * tileMapPool.length)) - 1;
				newTileMap = tileMapPool.members[assigner];
				
			}
			positionTileMap(referenceTileMap, newTileMap);
			return newTileMap;
		
		}
		
		/*
		 * Places a tilemap according to the coordinates of the other
		 * @param a referenceTileMap, this tile map is given to take it's coordinates and width
		 * @param a tileMapToPosition, this tile map will be placed in fron of the referenceTileMap
		 * */
		public function positionTileMap(referenceTileMap:FlxTilemap, tileMapToPosition:FlxTilemap):void
		{
			tileMapToPosition.reset(referenceTileMap.width + referenceTileMap.x, referenceTileMap.y);
		
		}
		
		/*
		 * generates an obstacle to be placed on the screen
		 * @param referenceObstacle, used to be pased to positionObstacle
		 * @returns FlxSprite obstacle with x and y coordinates depending on referenceObstacle and obstacle class
		 * */
		
		public function generateObstacles(referenceObstacle:FlxSprite):FlxSprite
		{
			var obstacle:FlxSprite;
			var assigner:Number = (Math.ceil(Math.random() * obstacleSpriteGroup.length)) - 1;
			obstacle = obstacleSpriteGroup.members[assigner];
			if (obstacle is Web)
			{
				obstacle = new Web(0, 0);
				positionObstacle(referenceObstacle, obstacle);
			}
			if (obstacle is WebGround)
			{
				obstacle = new WebGround(0, 0);
				positionObstacle(referenceObstacle, obstacle);
			}
			return obstacle;
		}
		
		/* positions the new obstacle to always be ahead of reference obstacle
		 * @param referenceObstacle, takes x position and width to place new obstacle ahead
		 * @param obstacleToPosition, new obstacle that will be placed in a random distance from 300 to 400 pixels ahead of referenceObstacle, y depends on the class of the obstacle
		 * */
		public function positionObstacle(referenceObstacle:FlxSprite, obstacleToPosition:FlxSprite):void
		{
			var betweenDistanceX:uint = (Math.ceil(Math.random() * 100)) + 300;
			
			if (obstacleToPosition is Web)
			{
				obstacleToPosition.x = referenceObstacle.x + referenceObstacle.width + betweenDistanceX;
				obstacleToPosition.y = 160;
			}
			if (obstacleToPosition is WebGround)
			{
				obstacleToPosition.x = referenceObstacle.x + referenceObstacle.width + betweenDistanceX;
				obstacleToPosition.y = 285;
			}		
		}
		
		/*
		 * determines the causes of players death
		 * @return Boolean if player is dead
		 * */
		public function gameOverTrigger():Boolean
		{
			var gameOver:Boolean = false;
			if (FlxCollision.pixelPerfectCheck(plyer, fullSpider.spider))
			{
				gameOver = true;
			}
			if (plyer.y >= 360)
			{
				gameOver = true;
			}
			return gameOver;
		}
		
		/*function to be executed on overlabse with obstacles
		 * @param plyer required for overlapse function
		 * @param web, required for overlapse funcion
		 * */
		public function hitWeb(plyer:FlxObject, web:FlxObject):void
		{
			web.flicker();
			deaccelarate();
		}
		
		/**
		 * This method is a NotifyCallback Function used when a minion is overlaped by a bullet
		 */ 
		public function destroyMinion(bullet:FlxObject, minion:FlxObject):void
		{			
			fullSpider.killMinion(minion);
		}	
		
		/*
		 * reduces players acceleration to 0
		 * */
		public function deaccelarate():void
		{
			plyer.acceleration.x = 0;
		
		}
			
	}

}