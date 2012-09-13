package  
{
	/**
	 * ...
	 * @author Jose
	 */
	import org.flixel.*;
	public class Web extends FlxSprite
	{
		[Embed(source = '/sprites/telaraña(119x94).png')] private var Graphic:Class;
		
		public function Web(x:uint,y:uint) 
		{
			this.x = x;
			this.y = y;
			loadGraphic(Graphic, true, true, 119, 94, true);
		}
		
	}

}