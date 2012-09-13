package  
{
	/**
	 * ...
	 * @author Jose
	 */
	import org.flixel.*;
	public class StartScreen extends FlxSprite
	{
		[Embed(source = '/sprites/startScreen.png')] private var Graphic:Class;
		
		public function StartScreen(x:uint, y:uint) 
		{
			this.x = x;
			this.y = y;
			loadGraphic(Graphic, false, false, 400, 300);
		}
		
	}

}