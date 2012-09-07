package  
{
	/**
	 * ...
	 * @author Jose
	 */
	import org.flixel.*;
	public class Player  extends FlxSprite
	{
		
	[Embed(source = '/assets/sprites/personaje(13x30).png')] private var Graphic:Class;
	
		public function Player(x:uint, y:uint) {
			super(x, y);
			
			loadGraphic(Graphic, true, true, 13, 30, true);
			width = 13;
			height = 30;
			
			addAnimation("Run", [0, 1, 0, 2], 9, false);
			addAnimation("RunFaster", [0, 1, 0, 2], 10, false);
			addAnimation("RunFastest", [0, 1, 0, 2], 11, false);
			addAnimation("Crapping", [3], 0, true);
			addAnimation("Hurt", [5, 5, 5, 5], 10, true);
			addAnimation("Jump", [4], 0, false);
			addAnimation("Slide", [6, 6, 6, 6],10,true);			
			
			maxVelocity.x = 80;
			maxVelocity.y = 200;
			acceleration.y = 200;
			drag.x = maxVelocity.x*1.5;			
		}	
	}
}