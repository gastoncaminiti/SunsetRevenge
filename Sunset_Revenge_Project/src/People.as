package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Spritemap;

	/*
	import net.flashpunk.FP;
 	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.masks.Masklist;
	import net.flashpunk.Mask;
	*/
	
	public class People extends Entity
	{
		
		private var _peopleAnim:Spritemap;
		private var _peopleToLeft:Boolean;
		
		public function People(px:Number, py:Number,IMG:Class,fw:Number,fh:Number,t:String) 
		{
			_peopleAnim = new Spritemap(IMG, fw, fh);
			super(px, py, _peopleAnim);
			setHitbox(fw*.2, fh *.8, -fw / 3,-fh / 6);
			type = t;
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
		
		public function setDirection(l:Boolean = false):void{
			 _peopleToLeft = l;
		}
		
		public function moveHorizontal(name:String,n:Number = 5):void{
			_peopleAnim.play(name);
			x+= _peopleToLeft ? n : -n ;
		}
	}

}