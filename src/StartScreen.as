package  
{
	/**
	 * ...
	 * @author Jose
	 */
	import org.flixel.*;
	public class StartScreen extends FlxSprite
	{
		[Embed(source = '/assets/sprites/startScreen.png')] private var Graphic:Class;
		
		public function StartScreen(x:uint, y:uint) {
			this.x = x;
			this.y = y;
			loadGraphic(Graphic, false, false, 400, 300);
			
			this.y = -100;
		}		
	}
	
}