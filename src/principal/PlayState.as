package principal
{
	import flashx.textLayout.operations.RedoOperation;
	
	import mx.containers.Box;
	
	import org.flixel.*;
	import org.flixel.system.FlxDebugger;
	
	/**
	 * This class creates the main stage PlayState > FlxState 
	 * @author Néstor Villalobos
	 */
	public class PlayState extends FlxState
	{
		//Player object
		private var player:Player;
		//FullSpider object
		private var fullSpider:FullSpider;
		//FlxTileblock object to represent a temporal floor
		private var floor:FlxTileblock;		

		public var sky:Sky;
		private var boxes:FlxGroup;
		private var infoText:FlxText;
		private var boxDebris:Debris;
		
		/**
		 * The constructor of this class.
		 * Creates a PlayState > FlxState object.
		 */
		public function PlayState()
		{
		}
		
		override public function create():void
		{
			boxDebris = new Debris(0,0);
			
			// Background color
			FlxG.bgColor = 0xFF363636;
			
			//Main objects initialization & adding
			player = new Player(155, FlxG.height/2);		
			
			floor = new FlxTileblock(0, FlxG.height/2+20, 4000, 240);
			floor.makeGraphic(4000, 240, 0xff1A1919);	
			
			fullSpider = new FullSpider(-50,10);
			
			infoText = new FlxText(240, 0, 100, "SPACE to jump");
			infoText.shadow = 0xff000000;
			infoText.scrollFactor.x = 0;
			infoText.scrollFactor.y = 0;
			
			boxes = new FlxGroup();
			boxes.add(new principal.Box(300,floor.y-12));
			boxes.add(new principal.Box(330,floor.y-32));
			boxes.add(new principal.Box(500,floor.y-12));
			boxes.add(new principal.Box(1000,floor.y-12));
			boxes.add(new principal.Box(1012,floor.y-12));
			boxes.add(new principal.Box(1500,floor.y-32));
			boxes.add(new principal.Box(1800,floor.y-12));
			
			sky = new Sky();
			
			//Adds
			add(sky);
			add(infoText);
			add(floor);									
			add(player);
			add(boxes);
			add(boxDebris);
			add(fullSpider);
			
			//Fixed camera to follow "player"		
			FlxG.worldBounds = new FlxRect(0, 0, floor.width, 240);
			FlxG.camera.setBounds(0, 0, floor.width, 240);
			FlxG.camera.follow(player,FlxCamera.STYLE_LOCKON);

			//Debug watches
			FlxG.watch(player.acceleration,"x","Player AccX");
			FlxG.watch(fullSpider.spider.acceleration,"x","Spider AccX");
			FlxG.watch(fullSpider.spider,"x","Player CoordX");
			
		}
		
		override public function update():void
		{
			//Default movement-values for "player"
			player.acceleration.x = player.maxVelocity.x*8;	
			
			
			var numDown:Number = 8;
			//Control setups
			if(FlxG.keys.DOWN) {
				player.height = numDown;
				player.offset.y = 10;
				if(FlxG.keys.justPressed("DOWN")){
					player.y += numDown;
					player.play("slide");
				}
			} else {
				player.height = 16;
				player.offset.y = 2;
				if(FlxG.keys.justReleased("DOWN")){
					player.y -= numDown;					
				}				
				player.play("walk");
			}
			
			if(FlxG.keys.justPressed("SPACE") && player.isTouching(FlxObject.FLOOR)){
				player.velocity.y = -player.maxVelocity.y/2;	
				player.play("jump");
			}	
			
			//Default movement/follow-values for "fullSpider"			
			fullSpider.spider.acceleration.x = fullSpider.spider.maxVelocity.x*8;
			fullSpider.spider.y = floor.y-fullSpider.spider.height/2-15;//player.y-fullSpider.spider.height/2;
			
			//Misc
			FlxG.overlap(player, boxes, hitBox);
			FlxG.overlap(player, fullSpider.spider, gameOver);
			FlxG.overlap(fullSpider.spider, boxes, destroyBox);						

			super.update();	
			
			//Colisions
			FlxG.collide(player, floor);
			FlxG.collide(boxes, floor);
			FlxG.collide(boxDebris, floor);
		}		
		
		/**
		 * This method desaccelerate the player
		 */
		public function desaccelerate():void
		{
			player.acceleration.x = 0;	
			player.play("hurt");
		}
		
		/**
		 * This method is a NotifyCallback Function used when a box is overlaped by Player
		 */ 
		public function hitBox(player:FlxObject, box:FlxObject):void
		{
			box.flicker();			
			desaccelerate();
		}
		
		/**
		 * This method is a NotifyCallback Function used when a box is overlaped by Spider
		 */ 
		public function destroyBox(spider:FlxObject, box:FlxObject):void
		{
			/*boxDispenser = new Debris(box.x+box.width/2,box.y);			
			add(boxDispenser);	*/
			boxDebris.x = box.x+box.width/2;
			boxDebris.y = box.y;
			boxDebris.start(true,5);
			
			box.kill();
		}	
		
		/**
		 * This method is a NotifyCallback Function used when Spider overlaps Player
		 */ 
		public function gameOver(player:FlxObject, spider:FlxObject):void
		{
			FlxG.switchState(new OverState());
		}
	}	
}