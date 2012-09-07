package  
{
	/**
	 * ...
	 * @author Jose
	 */
	import org.flixel.*;
	public class GameOverScreen extends FlxSprite
	{
		[Embed(source = '/assets/sprites/gameOverScreen.png')] private var Graphic:Class;
		
		public function GameOverScreen (x:uint, y:uint) 
		{
			this.x = x;
			this.y = y;
			loadGraphic(Graphic, false, false, 400, 300);
			
			this.y = -100;
		}
		
		
	}

}