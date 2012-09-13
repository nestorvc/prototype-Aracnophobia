package  
{
	/**
	 * ...
	 * @author Jose
	 */
	import org.flixel.*;
	public class Vino extends FlxSprite
	{
		[Embed(source = '/sprites/vino(300x150).png')] private var Graphic:Class;
		public function Vino(x:uint, y:uint) 
		{
			this.x = x;
			this.y = y*16;
			loadGraphic(Graphic, true, false, 300, 150);
		}
		
	}

}