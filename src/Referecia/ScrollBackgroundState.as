package  
{
	/**
	 * ...
	 * @author Jose
	 */
	import org.flixel.*;
	
	public class ScrollBackgroundState extends FlxState
	{
		
		//first sprites, also used to keep loop
		//will not be included in pool
		private var sprite1:FlxSprite;
		private var sprite2:FlxSprite;
		//available sprites to add to pool FlxGroup
		private var amarillo:Amarillo;
		private var morado:Morado;
		private var verde:Verde;
		private var vino:Vino;
		//group where sprites will be added
		private var group:FlxGroup;
		//speed at which the sprites move
		private var speed: Number;
		//on screen text
		private var text:FlxText;
		private var infoText:FlxText;
		//control boolena variable
		private var added:Boolean;
		
		override public function create():void {
		//variable initialization
			speed = 1;
			
			group = new FlxGroup();
			
			text = new FlxText(20, 20, 80);
			infoText = new FlxText(300, 20, 100, "X to simulate collition");
			
			sprite1 = new Vino(0, 10);
			sprite2 = new FlxSprite();

			amarillo = new Amarillo(0, 0);
			verde = new Verde(0, 0);
			morado = new Morado(0, 0);
			vino = new Vino(0, 0);
			
			addSpriteToPool(amarillo);
			addSpriteToPool(morado);
			addSpriteToPool(verde);
			addSpriteToPool(vino);
			
			added = false;
		//adding first elements to state
			add(sprite1);
			add(text);
			add(infoText);
			
			}
			
			override public function update():void {
				//calls movement and acceleration
				moveSprite(sprite1);
				moveSprite(sprite2);
				//if and else if to keep sprite generation
				if (sprite1.x <= 100 && added == false) {
					sprite2.kill();
					sprite2 = generateSprite(sprite1);
					add(sprite2);
					added = true;
					}	
				else if (sprite2.x <= 100 && added == true) {
					sprite1.kill();
					sprite1 = generateSprite(sprite2);
					add(sprite1);
					added = false;
					}	
				// x key to call deaccelaration method and
				//reduce speed
				else if (FlxG.keys.justPressed("X")) {
				deacceleration();
				}	

				super.update();
				
				}
				
				//returns a sprite randomly from a flxGroup with
				//x and y coordinates relevant to reference sprite provided
				//ensures that every sprite spawned will be different
				//from previews one
				public function generateSprite(referenceSprite:FlxSprite):FlxSprite {
					var rs:FlxSprite;
					rs = referenceSprite;
					while (rs == referenceSprite)
					{
					var assigner:Number = Math.ceil(Math.random() * group.members.length)-1;
					rs = group.members[assigner]; 
					rs.revive();
					}
					positionSprite(referenceSprite, rs);
					return rs;
					}
					
				//Sets the sprite in position to be
				 // on the same y axis of the reference sprite
				 //and to next to it on the x axis to 
				 // prevent collition	
				public function positionSprite(referenceSprite:FlxSprite, spriteToPosition:FlxSprite):void {
						
						spriteToPosition.reset(referenceSprite.width + referenceSprite.x, referenceSprite.y);
						
						}
					
				//Adds a Sprite to the FlxGroup group
				 //this sprites will be used in generateSprite
				 //to create the level
				 //If the sprite already exists in the pool it won't be added
					public function addSpriteToPool(sprite:FlxSprite):void {
						if(group.members.indexOf(sprite) == -1){
						group.add(sprite);
						}
						}	
							
							
				//Moves sprite on y axis
				 //creates an acceleration effect
				 //controled by the speed variable
				 //the higher speed is the lowest the 
				 //accelaration ratio is
				 		
					public function moveSprite (sprite:FlxSprite):void {
								
								sprite.x -= speed;
								if (speed <= 3) {
									speed += 0.0020;
									text.text = "Speed: "+ speed.toString();
									}
								else if (speed >= 3 && speed <= 4) 
								{
									speed += 0.0007;
									text.text = "Speed: "+ speed.toString();
									}
								else if (speed >= 4 && speed <= 6) 
								{
									speed += 0.0003;
									text.text = "Speed: "+ speed.toString();
									}	
								else if (speed >= 6 && speed <= 8) 
								{
									speed += 0.0002;
									text.text = "Speed: "+ speed.toString();
									}	
								else if (speed >= 8 && speed <= 10) 
								{
									speed += 0.0001;
									text.text = "Speed: "+ speed.toString();
									}	
									
								}	
					
					//Reduces the speed of the scrolling sprites
					// by %20
					 			
					public function deacceleration():void {
						speed -= (20 * speed) / 100;
						}
						
						}
						
						
		
	}

