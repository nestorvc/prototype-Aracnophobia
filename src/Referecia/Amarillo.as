package  
{
	/**
	 * ...
	 * @author Jose
	 */
	import org.flixel.*;
	public class Amarillo extends FlxSprite
	{
		[Embed(source = '/sprites/amarillo(300x150).png')] private var Graphic:Class;
		public function Amarillo(x:uint, y:uint) 
		{
			this.x = x;
			this.y = y*16;
			loadGraphic(Graphic, true, false, 300, 150);
		}
		
	}

}