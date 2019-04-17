package 
{
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.Entity;
	
	public class Player extends People
	{
		
		[Embed(source = "img/Player.png")]
		private const PLAYER_ANIM:Class;
		
		public  var _shield:Entity;
		private var _shoot:Boolean;
		private var _firerate:Number;
		private var _clockfire:Number;
		
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
			_shield = new Entity(x, y);
			_shield.setHitbox(20, 80,-120,-24);
			_shield.type = "shield";
			_shield.collidable = false;
			_shoot = false;
			_firerate = 18;
			_clockfire = 0;
			setLife(3);
  		}
 
		public function stand():void {
			_shield.collidable = false;
			playAnimation("stand");
		}
		
		public function walkLeft():void{
			setFlip(false);
			setDirection(false);
			_shield.collidable = false;
			_shield.setHitbox(20, 100,-20,-24);
			moveHorizontal("walk",10);
		}
		
		public function walkRight():void{
			setFlip(true);
			setDirection(true);
			_shield.collidable = false;
			_shield.setHitbox(20, 100,-120,-24);
			moveHorizontal("walk",10);
		}
 
		public function shoot():void{
			playAnimation("range_atack");
		}
		
		public function block():void {
			_shield.collidable = true;
			playAnimation("block");
		}
		
		public function crouch():void{
			playAnimation("crouch");
		}

		public function jump():void{
			y -= 50;
			playAnimation("jump");
		}

		public function atack():void {
			_shield.collidable = true;
			if(getFlip())
				_shield.setHitbox(80, 100, -120, -24);
			else
				_shield.setHitbox(80, 100, 30, -24);
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
		
		public function isBlock():void {
			var p:Projectile = _shield.collide("Bullet", _shield.x, _shield.y) as Projectile;
			if (p) {
				p.destroy();
			}
		}
		
		override public function update():void
		{	
			_shield.x = x;
			_shield.y = y;
			
			isHurt();
			isBlock();
			if (isDead()) {
				playAnimation("dead");
				if (collidable) {
					x -= 20;
					y -= 5;
					collidable = false;
					_shield.collidable = false;
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