package 
{
	import org.flixel.*;
	
	public class RedBox extends FlxSprite
	{
		
		public function RedBox(X:Number, Y:Number) 
		{
			super(X, Y);
			
			makeGraphic(10,12,0xffaa1111);
			acceleration.y = 400;
			drag.x = 200;
			moves = false;
		}
	}
}