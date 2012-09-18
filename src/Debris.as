package 
{
	import org.flixel.*;
	
	public class Debris extends FlxEmitter
	{
		//Image source for the debris sprite
		[Embed(source='/sprites/gibs2.png')] private var ImgDebris:Class;
		
		/**
		 * The constructor of this class.
		 * Creates a FlxEmitter object.
		 * @param Number X coordinate
		 * @param Number Y coordinate
		 * @param Number Max size of particles allowed in this FlxEmitter > FlxGroup. If 0, it is dynamic. 
		 */
		
		public function Debris(X:Number=0, Y:Number=0, Size:Number=0)
		{
			super(X, Y, Size);		
			
			setSize(7,7);
			setXSpeed(0,250);
			setYSpeed(-20,100);
			gravity = 150;
			bounce = 0.5;
			makeParticles(ImgDebris,20,32,true,0.8);
			particleDrag.x = 1000;
			//start(true,5);	
		}
	}
}