package  
{
	/**
	 * ...
	 * @author Jose
	 */
	import org.flixel.*;
	import org.flixel.plugin.photonstorm.*;
	public class Player  extends FlxSprite
	{
	[Embed(source = '/sprites/bichinNuevo(42x71).png')] private var Graphic:Class;
	//image for the player's weapon
	[Embed(source = '/sprites/bullet(15x15).png')] private var WeaponPNG:Class;
	//weapon variable
	public var bullet:FlxWeapon;
	//Auxiliar var to control Slide actions
	private var auxSlide:Number;
	//Auxiliar var to control jump action
	public var auxJump:Number;

	
		public function Player(x:uint, y:uint, bulletAmount:uint) 
		{
			this.x = x;
			this.y = y;
			loadGraphic(Graphic, true, true, 42, 71, true);
			addAnimation("Run", [0, 1, 2, 0, 1, 3], 10, false);
			addAnimation("Hurt", [1, 1, 1, 1], 10, true);
			addAnimation("Jump", [0], 0, true);
			addAnimation("RunSmall", [8, 9, 10, 8, 9, 11], 10, true);
			
			//weapon creation with player's x and y position
			bullet = new FlxWeapon("bullet", this, "x", "y");
			//creating weapon sprite with image and providing ammo amount
			bullet.makeImageBullet(bulletAmount, WeaponPNG,10,15);
			//bullet direction and speed
			bullet.setBulletDirection(FlxWeapon.BULLET_RIGHT, 600);
			
			maxVelocity.x = 380;
			maxVelocity.y = 600;
			acceleration.y = 800;
			drag.x = maxVelocity.x * 1.5;
			
			auxSlide = Math.floor(height / 2);
			
			auxJump = 0;
			
			
			
		}
		
		override public function update():void 
		{
			
			//increases jump control variable for a certain ammount of time x button has been held, if held longer it sets it to -1
			if(auxJump >= 0 && FlxG.keys.X){
				auxJump += FlxG.elapsed;
					if(auxJump >= 0.45){
							auxJump = -1;
					}

				}		
			//Controls player not being able to double jump
			if (FlxG.keys.justReleased("X")) {
				auxJump = -1;
				}
			//Checks if the player is touching the floor, inf jump control variable is larger than 0 and  if key x has been
			//pressed player will jump, depending on how long keys was pressed
				if (auxJump > 0 && FlxG.keys.X)
			{
				if(auxJump < 0.065)
					velocity.y = -maxVelocity.y / 2;
				else	
					velocity.y = -maxVelocity.y/2 - maxVelocity.y/10;
			}
			
			

			
			//Checks if the player is touching the floor, if key c has been
			//just pressed player will slide
			if(FlxG.keys.C) {
				height = auxSlide;
				width = 71;
				offset.y = 20;
				offset.x = -15;
				
				if(FlxG.keys.justPressed("C")){
					y += auxSlide;
					//plyer.play("XXX");
					angle = -90;
				}
			} else {
				height = 71;
				width = 42;
				offset.y = 0;
				offset.x = 0;
				
				if(FlxG.keys.justReleased("C")){
					y -= auxSlide;
					angle = 0;
				}				
				play("Run");
			}
			//Fire bullet pressing Space
			
			if (FlxG.keys.justPressed("SPACE"))
			{
				bullet.fire();
				bullet.setBulletBounds(FlxG.worldBounds);
			}
			
			super.update();
			//sets jump control variable to 0 when player has just touched the floor
		if (isTouching(FlxObject.FLOOR)) {
			auxJump = 0;
			}	
			
		}
		
		
	}

}