package 
{
	import net.flashpunk.FP;
	
	public class Cameramanager 
	{
		private static var _offset:int = 200;
		private static var _speed:int = 2;
		private static var _followx:int = 0;
		private static var _followy:int = 0;
		
		public static function setCameraConfig(x:Number = 0, y:Number = 0, o:Number = 200, s:Number = 2):void 
		{
			_offset  = o;
			_speed   = s;
			_followx = x;
			_followy = y;
		}

		public static function followCamera():void 
		{
			if (_followx - FP.camera.x < _offset) {
				if (FP.camera.x > 0)
					FP.camera.x -= _speed * FP.elapsed;
			}else if((FP.camera.x + FP.width) - (_followx + 170) < _offset){
				if (FP.camera.x + FP.width < 6600)
						FP.camera.x += _speed * FP.elapsed;
			}
			
			if (_followy - FP.camera.y < _offset) {
				/*
				if (FP.camera.y > 0) {
					FP.camera.y += _speed * FP.elapsed;
				}
				*/
			}else if((FP.camera.y + FP.height) - (_followy + 170) < _offset){
				if (FP.camera.y + FP.height < 1200) {
					FP.camera.y += _speed * FP.elapsed;
				}
			}
			
		}
		
		public static function getCameraX():Number 
		{
			return FP.camera.x;
		}
		
		public static function getCameraY():Number 
		{
			return FP.camera.y;
		}
	}

}