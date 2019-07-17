package gameclass 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	import net.flashpunk.graphics.Spritemap;
	
	import gamemanager.CameraManager;
	
	public class Feather extends Entity
	{
		
		[Embed(source="../asset/img/FeatherA.png")]
		private const FLIFE_IMG:Class;
		
		[Embed(source="../asset/img/FeatherB.png")]
		private const FSPECIAL_IMG:Class;
		
		private var featherImage:Image;
		private static var FEATHER_SIZE:int = 24;
		
			
		public function Feather(px:Number = 0, py:Number = 0, pt:Number = 1) 
		{
			featherImage = pt ? new Image(FLIFE_IMG) : new Image(FSPECIAL_IMG);
			super(px, py, featherImage);
		}
		
		public static function get_size():int
		{		
			return FEATHER_SIZE;
		}
		
		public function destroy():void
		{
			// Here we could place specific destroy-behavior for the Bullet.
			FP.world.remove(this);
		}
		
	}

}