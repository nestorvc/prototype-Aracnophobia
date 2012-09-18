package
{
	import org.flixel.*;
	
	public class Minion extends FlxSprite
	{
		//Image source for the player sprite
		[Embed(source = '/sprites/baddie_cat_2.png')] private var minionPNG:Class;
		public static var distance:Number;
		
		public function Minion(X:Number=0, Y:Number=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			
			loadGraphic(minionPNG, true, true, 32, 32, true);
			width = 32;
			height = 32;
			offset.x = 2;
			offset.y = 2;
			
			distance = 1000;
			
			addAnimation("idle", [2], 0, false);
			addAnimation("walk", [2, 3], 10, true);
			
			maxVelocity.x = 80;
			maxVelocity.y = 300;
			acceleration.y = 200;
			velocity.y = -maxVelocity.y;
			drag.x = maxVelocity.x*5;
		}
		
		override public function update():void
		{
			if(this.y > FlxG.height) kill();
			
			super.update();
		}
		
		public function eject():void
		{
			play("walk");
			
			if(!this.isTouching(FlxObject.FLOOR)) {
				velocity.x = distance;
			} else {
				velocity.x = -100;
			}
		}
	}
}