package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.FP;

	public class People extends Entity
	{
		
		private var _peopleAnim:Spritemap;
		private var _peopleToLeft:Boolean;
		private var _life:Number;
		
		public function People(px:Number, py:Number,IMG:Class,fw:Number,fh:Number,t:String, l:Number=0) 
		{
			_peopleAnim = new Spritemap(IMG, fw, fh);
			super(px, py, _peopleAnim);
			setHitbox(fw*.2, fh *.8, -fw / 3,-fh / 6);
			type = t;
			_life = l;
  		}
		
 		public function addAnimation(name:String, frames:Array, frameRate:Number = 0, loop:Boolean = true):void{
			_peopleAnim.add(name, frames, frameRate, loop);
		}
		
		public function playAnimation(name:String):void {
			 _peopleAnim.play(name);
		}
		
		public function setFlip(f:Boolean = false):void{
			  _peopleAnim.flipped = f;
		}
		
		public function getFlip():Boolean{
			  return _peopleAnim.flipped;
		}
		
		public function setDirection(l:Boolean = false):void{
			 _peopleToLeft = l;
		}
		
		public function endAnimation():Boolean {
			 return _peopleAnim.complete
		}
		
		public function isAnimation(name:String):Boolean {
			 return _peopleAnim.currentAnim == name;
		}
		
		public function setLife(n:Number = 1):void{
			_life = n;
		}
		
		public function getLife():Number{
			return _life;
		}
		
		public function isDead():Boolean {
			return _life <= 0;
		}
		
		public function isTouchProjectile(p:String):Projectile {
			return collide(p, x, y) as Projectile;
		}
		
		public function moveHorizontal(name:String,n:Number = 5):void{
			_peopleAnim.play(name);
			x+= _peopleToLeft ? n : -n ;
		}
	}

}