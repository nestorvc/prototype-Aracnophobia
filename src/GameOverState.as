package  
{
	/**
	 * ...
	 * @author Jose
	 */
	import org.flixel.*;
	
	public class GameOverState extends FlxState
	{
		private var overScreen:GameOverScreen;
		
		
		override public function create():void {
			
			overScreen = new GameOverScreen(0, 0);
			
			add(overScreen);
			
			}
		override public function update():void {
			
			super.update();
			
			}
	}

}