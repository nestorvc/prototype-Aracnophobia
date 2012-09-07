package 
{
	import org.flixel.FlxGroup;
	
	/**
	 * This class creates a FlxGroup composed by Spider and the debris Dispenser
	 * @author Néstor Villalobos
	 */
	public class FullSpider extends FlxGroup
	{
		//Spider object
		public var spider:Spider;
		//Dispenser object
		public var dispenser:Dispenser;
		
		/**
		 * The constructor of this class.
		 * Creates a FullSpider > FlxGroup object.
		 * @param Number X coordinate
		 * @param Number Y coordinate
		 * @param uint Max size of particles allowed in this FlxGroup. If 0, it is dynamic. 
		 */
		public function FullSpider(X:Number, Y:Number, MaxSize:uint=0)
		{
			super(MaxSize);

			spider = new Spider(X,Y);
			dispenser = new Dispenser(spider.width-30,spider.height/2);		
			
			add(spider);			
			add(dispenser);	
		}
		
		override public function update():void{
			dispenser.x = (spider.x+spider.width-20);
			dispenser.y = (spider.y+spider.height/2);
			super.update();
		}
	}
}