package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	
	public class Enemy extends Entity
	{
		
		[Embed(source = "img/Enemies.png")]
		private const ENEMI_ANIM:Class;
		private var playerAnim:Spritemap;
		public var isDead:Boolean;
		public var isLeft:Boolean;
		public var isWin:Boolean;
		public var isCarrot:Boolean;
		public var isJump:Boolean;
		public var isReset:Boolean;
		private var isGravity:Boolean;
		/*
		[Embed(source = "sound/coin.mp3")]	
		protected const ENTER_MP3:Class;
		protected var entersfx:Sfx;
		*/
		
		public function Enemy(px:Number = 0, py:Number = 0) 
		{
			playerAnim = new Spritemap(ENEMI_ANIM, 180, 180);
			playerAnim.add("stand", [7], 10, false);
			playerAnim.add("walk", [0, 1, 2, 3,5], 10, false);
			//playerAnim.add("crouch", [3], 10, false);
			//playerAnim.add("block", [17], 10, false);
			//playerAnim.add("jump", [7], 10, false);
			//playerAnim.add("melee_atack", [0, 4, 0], 10, false);
			//playerAnim.add("range_atack", [0, 5, 6], 10, false);
			//playerAnim.add("special_atack", [8,9,10,11], 10, true);
			//playerAnim.add("dead", [4], 8, false);
			//playerAnim.add("win", [5], 8, false);
			super(px, py, playerAnim);
			playerAnim.play("stand");
			/*
			setHitbox(70, 100, -10, -10); // Corrección AABB
			type = "Player";
			isDead = false;
			isWin  = false;
			isCarrot = false;
			isJump = false;
			isGravity = true;
			isReset = false;
			isLeft = false;
			playerAnim.flipped = true;
			*/
			//entersfx = new Sfx(ENTER_MP3);
  		}
		
		public function run():void{
			playerAnim.play("walk");
			x-=10;
		}
		override public function update():void
		{		
			
			/*
			if (y < 450) {
				isGravity = true;
			}
			else {
				isGravity = false;
			}
				
			if (isGravity) {
					y+=10;
			}	
			
			
			
			if (Input.check(Key.Q))
				playerAnim.play("block");
				
			if (Input.check(Key.W)) {
				y -= 50;
				playerAnim.play("jump");
			}
			
			if (Input.check(Key.E))
				playerAnim.play("melee_atack");
			if (Input.check(Key.R))
				playerAnim.play("range_atack");
			if (Input.check(Key.F))
				playerAnim.play("special_atack");
				
			if (Input.check(Key.A)) {
				playerAnim.play("walk");
				isLeft = true;
				x-=10;
			}
			
			if (Input.check(Key.D)) {
				playerAnim.play("walk");
				isLeft = false;
				x += 10;
			}
			
			if (isLeft)
				playerAnim.flipped = false;
			else 
				playerAnim.flipped = true;
			*/
			
			/*
			if (!Input.check(Key.A)) 
				if (!Input.check(Key.D)) playerAnim.play("stand");
			if (!Input.check(Key.D) ) 
				if(!Input.check(Key.A))playerAnim.play("stand");	
			*/
			/*
			if (this.collide("plataforma", this.x, this.y)) {
				isGravity = false;
			}
			
			if (this.collide("planta", this.x, this.y)) {
				isGravity = false;
			}
			
			if (!this.collide("planta", this.x, this.y) && !this.collide("plataforma", this.x, this.y))
				isGravity = true;
			
			if (this.collide("coin", this.x, this.y)) {
				entersfx.play();
				isWin = true;
			}

			if (y >= 600)
				isReset = true;
			*/	
		}
		
	}

}