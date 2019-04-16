package 
{
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	
	public class Player extends People
	{
		
		[Embed(source = "img/Player.png")]
		private const PLAYER_ANIM:Class;
		
		public function Player(px:Number = 0, py:Number = 0) 
		{
			super(px, py, PLAYER_ANIM, 170, 170, "Player");
			addAnimation("stand", [0], 10, false);
			addAnimation("walk", [0, 1, 2, 1], 10, true);
			addAnimation("crouch", [3], 10, false);
			addAnimation("block", [17], 10, false);
			addAnimation("jump", [7], 10, false);
			addAnimation("melee_atack", [0, 4, 0], 10, false);
			addAnimation("range_atack", [0, 5, 6], 10, false);
			addAnimation("special_atack", [8,9,10,11], 10, true);
			addAnimation("dead", [12,13], 0.5, false);
			addAnimation("win", [15,16], 8, false);
			playAnimation("stand");
			setFlip(true);
			setLife(3);
  		}
 
		public function stand():void{
			playAnimation("stand");
		}
		
		public function walkLeft():void{
			setFlip(false);
			setDirection(false);
			moveHorizontal("walk",10);
		}
		
		public function walkRight():void{
			setFlip(true);
			setDirection(true);
			moveHorizontal("walk",10);
		}
 
		public function shoot():void{
			playAnimation("range_atack");
		}
		
		public function block():void{
			playAnimation("block");
		}
		
		public function crouch():void{
			playAnimation("crouch");
		}

		public function jump():void{
			y -= 50;
			playAnimation("jump");
		}

		public function atack():void{
			playAnimation("melee_atack");
		}
		
		public function specialatack():void{
			playAnimation("special_atack");
		}
		
		public function isWalk():Boolean{
			return isAnimation("walk");
		}
		
		public function hurt():void {
			setLife(getLife() - 1);
		}
		
		public function isHurt():void {
			var p:Projectile = isTouchProjectile("Bullet");
			if (p) {
				hurt();
				p.destroy();
			}
		}
		
		override public function update():void
		{	
			isHurt();
			if (isDead()) {
				playAnimation("dead");
				if (collidable) {
					x -= 20;
					y -= 5;
					collidable = false;
				}
			}
			/*
			if (y < 400) {
				isGravity = true;
			}
			else {
				isGravity = false;
			}
				
			if (isGravity) {
					y+=10;
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