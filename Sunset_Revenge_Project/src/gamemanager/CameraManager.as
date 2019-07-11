package gamemanager 
{
	import net.flashpunk.FP;
	
	public class CameraManager 
	{
		private static var _offset:int = 200;
		private static var _speed:int = 2;
		private static var _followx:int = 0;
		private static var _followy:int = 0;
		private static var _limitstagex:int;
		private static var _limitstagey:int;
		
		/*DEFINICION DE CONSTANTES DE DIMENSION DEL MAPA */
		public static var MAP_LIMIT_X_MIN:int = 0;
		public static var MAP_LIMIT_X_MAX:int = 6600;
		public static var MAP_LIMIT_Y_MIN:int = 0;
		public static var MAP_LIMIT_Y_MAX:int = 1200;		
		
		public static function setCameraConfig(x:Number = 0, y:Number = 0, o:Number = 200, s:Number = 2):void 
		{
			_followx = x;
			_followy = y;
			_offset  = o;
			_speed   = s;
		}

		public static function followCamera():void 
		{
			/* SEGUIMIENTO DE CAMARA HORIZONTAL */
			if ((_followx - _offset) >= MAP_LIMIT_X_MIN && (_followx + (_offset * 2)) <= MAP_LIMIT_X_MAX)
				FP.camera.x = _followx - _offset;
			/* SEGUIMIENTO DE CAMARA VERTICAL */
			if (_followy < FP.height)
				FP.camera.y = MAP_LIMIT_Y_MIN 
			else
				FP.camera.y = MAP_LIMIT_Y_MAX/2
				
			trace(FP.camera.y)
		}
		

		public static function getLimitX():int
		{
			return _limitstagex;
		}
		
		
		public static function getLimitY():int
		{
			return _limitstagey;
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