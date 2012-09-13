package  
{
	/**
	 * ...
	 * @author Jose
	 */
	import org.flixel.*;
	public class Morado extends FlxSprite
	{
		[Embed(source = '/sprites/morado(300x150).png')] private var Graphic:Class;
		public function Morado(x:uint, y:uint) 
		{
			this.x = x;
			this.y = y*16;
			loadGraphic(Graphic, true, false, 300, 150);
		}
		
	}

}