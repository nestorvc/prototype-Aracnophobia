package  
{
	/**
	 * ...
	 * @author Jose
	 */
	import org.flixel.*;
	
	public class StartState extends FlxState
	{
		private var startScreen:StartScreen;
		
		public function StartState() {			
		}
		
		override public function create():void {			
			startScreen = new StartScreen(0, 0);
			add(startScreen);
		}
		
		override public function update():void {
			if (FlxG.keys.justPressed("X")) {
				FlxG.flash(0xffffffff, 1, null, false);
				FlxG.fade(0xff000000, 1,callPlayState,true);				
			}
			
			super.update();			
		}	
		
		public function callPlayState():void {
			FlxG.switchState(new TestState);
		}
	}	
}