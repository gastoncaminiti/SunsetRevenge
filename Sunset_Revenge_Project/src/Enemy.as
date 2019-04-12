package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
 	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.masks.Masklist;
	import net.flashpunk.Mask;
	
	public class Enemy extends People
	{
		
		[Embed(source = "img/Enemies.png")]
		private const ENEMI_ANIM:Class;

		public var isDead:Boolean;
		public var isLeft:Boolean;
		public var isWin:Boolean;
		public var isCarrot:Boolean;
		public var isJump:Boolean;
		public var isReset:Boolean;
		private var isGravity:Boolean;
		
		public var h1:Hitbox;
		public var h2:Hitbox;
		public var m:Masklist;
		
		/*
		[Embed(source = "sound/coin.mp3")]	
		protected const ENTER_MP3:Class;
		protected var entersfx:Sfx;
		*/
		
		public function Enemy(px:Number = 0, py:Number = 0, t:Number = 0) 
		{
			super(px, py, ENEMI_ANIM, 180, 180, "Enemy");
			if (t){
				addAnimation("stand", [7], 10, false);
				addAnimation("walk", [0, 1, 2, 3, 4, 5], 12, false);
				addAnimation("shoot", [6, 5], 8, false);
				addAnimation("shootdown", [9, 8,9], 8, false);
			}else {
				addAnimation("stand", [17], 10, false);
				addAnimation("walk", [10, 11, 12, 13, 14, 15], 12, false);
				addAnimation("shoot", [16, 15], 8, false);
				addAnimation("shootdown", [19, 18,19], 8, false);
			}
			playAnimation("stand");
  		}
		
		public function run():void {
			moveHorizontal("walk",30);
		}
		
		public function shoot():void {
			playAnimation("shoot");
		}
		
		public function shootDown():void {
			playAnimation("shootdown");
		}
		
		override public function update():void
		{		
			
		}
		
	}

}