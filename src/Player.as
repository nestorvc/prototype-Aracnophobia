package  
{
	/**
	 * ...
	 * @author Jose
	 */
	import org.flixel.*;
	public class player  extends FlxSprite
	{
	[Embed(source = '/sprites/bichinNuevo(42x71).png')] private var Graphic:Class;
	
		public function player(x:uint, y:uint) 
		{
			this.x = x;
			this.y = y;
			loadGraphic(Graphic, true, true, 42, 71, true);
			addAnimation("Run", [0, 1, 2, 0, 1, 3], 10, false);
			addAnimation("Hurt", [1, 1, 1, 1], 10, true);
			addAnimation("Jump", [0], 0, true);
			addAnimation("RunSmall", [8, 9, 10, 8, 9, 11], 10, true);

			maxVelocity.x = 280;
			maxVelocity.y = 420;
			acceleration.y = 460;
			drag.x = maxVelocity.x*1.5;
			
		}
		
		
	}

}