package 
{
	import org.flixel.*;
	
	/**
	 * This class creates the Player > FlxSprite
	 * @author Néstor Villalobos
	 */
	public class Player extends FlxSprite
	{
		//Image source for the player sprite
		[Embed(source = '../assets/player.png')] private var playerPNG:Class;
		
		/**
		 * The constructor of this class.
		 * Creates a Player > FlxSprite object.
		 * By default the Player will have a hitbox smaller than the original sprite image
		 * Also some default animations have been included ("idle", "walk", "jump", "hurt")
		 * Finally, default values have been setted to the maxVelocity, acceleration and drag properties.
		 * @param Number X coordinate
		 * @param Number Y coordinate
		 */
		public function Player(X:Number, Y:Number)
		{
			super(X, Y);
			loadGraphic(playerPNG, true, true, 16, 18, true);
			width = 12;
			height = 16;
			offset.x = 2;
			offset.y = 2;
			
			addAnimation("idle", [0], 0, false);
			addAnimation("walk", [0, 1, 0, 2], 10, true);
			addAnimation("jump", [1], 0, false);
			addAnimation("hurt", [3,3,3,3], 10, true);
			
			maxVelocity.x = 80;
			maxVelocity.y = 200;
			acceleration.y = 200;
			drag.x = maxVelocity.x*1.5;
		}
		
		override public function update():void
		{

		}
		
	}
}