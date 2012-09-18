package 
{
	import org.flixel.*;
	
	/**
	 * This class creates a FlxGroup composed by Spider and the debris Dispenser
	 * @author Néstor Villalobos
	 */
	public class FullSpider extends FlxGroup
	{
		//Spider object
		public var spider:Spider;
		//Minions group
		public var minions:Minions;
		//Dispenser object
		public var dispenser:Dispenser;
		//Timer for minions
		private var timer:FlxTimer;
		//Minion flesh
		public var minionFlesh:Debris;
		
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
			minions = new Minions(spider, 15);
			dispenser = new Dispenser(spider.width-30,spider.height/2);		
			timer = new FlxTimer();
			minionFlesh = new Debris(0,0);
								
			add(minions);
			add(minionFlesh);	
			add(spider);			
			add(dispenser);	
			
			timer.start(3,2,onTimer);
			
			//Watchs
			FlxG.watch(timer, "time", "T-");
			FlxG.watch(timer, "loops", "Loops #");
		}
		
		override public function update():void{
			//Default movement-values for "minion"
			minions.callAll("eject",true);
			
			//Timer setup
			timer.time = (Math.random()*5)+2;
			timer.loops++;
			
			//Default movement-values for "dispenser"
			dispenser.x = (spider.x+spider.width-20);
			dispenser.y = (spider.y+spider.height/2);
			
			//Overlaps
			FlxG.overlap(spider, minions, returnMinion);
			
			super.update();
		}
		
		/**
		 * Kills a minion if it return to Spider
		 * @param spider The minioms' mother
		 * @param miniom The miniom that Spider overlaps
		 */
		public function returnMinion(spider:FlxObject, minion:FlxObject):void
		{
			if(minion.x < spider.x+spider.width/2){
				minion.kill();
			}
		}	
		
		/**
		 * Launch a minion every time the Timer ends
		 * @param timer The timer
		 */
		public function onTimer(timer:FlxTimer):void 
		{
			minions.launch();
		}
		
		public function killMinion(minion:FlxObject):void{
			minionFlesh.x = minion.x+minion.width/2;
			minionFlesh.y = minion.y;
			minionFlesh.start(true,5);
			
			minion.kill();	
		}
	}
}