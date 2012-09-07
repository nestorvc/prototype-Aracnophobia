package  
{
	/**
	 * ...
	 * @author Jose
	 */
	import org.flixel.*;
	public class Background extends FlxSprite
	{
		[Embed(source = '/assets/sprites/cloudBack.png')] private var Graphic:Class;
		public function Background(x:uint, y:uint) 
		{
			this.x = x;
			this.y = y;
			loadGraphic(Graphic, false, false, 400, 300);

		}
		
	}

}