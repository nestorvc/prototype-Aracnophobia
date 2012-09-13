package 
{
	import org.flixel.*;

	/**
	 * This class creates the Spider > FlxSprite
	 * @author Néstor Villalobos
	 */
	public class Spider extends FlxSprite
	{
		//Image source for the spider sprite
		[Embed(source = '/sprites/aranaNueva(331x338).png')] private var aranaPNG:Class;
		
		/**
		 * The constructor of this class.
		 * Creates a Spider > FlxSprite object.
		 * By default values have been setted to the maxVelocity, acceleration and drag properties.
		 * @param Number X coordinate
		 * @param Number Y coordinate
		 */
		public function Spider(X:Number, Y:Number) 
		{
			super(X, Y);
			loadGraphic(aranaPNG,true,false,331,338);
			
			maxVelocity.x = 200;
			maxVelocity.y = 100;
			/*acceleration.y = 200;*/
			drag.x = maxVelocity.x * 2;
			addAnimation("Bite", [0,1,2,1], 10, true);
		}
	}
}