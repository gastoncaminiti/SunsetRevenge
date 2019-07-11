package gamemanager 
{
	public class DataManager 
	{
		private static var _highScore:int = 10;
		private static var _levelwin:Boolean = false;
		private static var _indexstage:Number = 1;
	
		public static function getScore():int {
			return _highScore;
		}
		
		public static function addScore(v:int):void {
			_highScore += v;
		}
		
		public static function resetScore():void {
			_highScore = 0;
		}
		
		public static function setLevelWin(new_state:Boolean = false):void {
			_levelwin = new_state
		}
		
		public static function isLevelWin():Boolean {
			return _levelwin;
		}
		
		public static function set_stage(new_stage:Number):void {
			_indexstage = new_stage;
		}
		
		public static function get_stage():Number {
			return _indexstage;
		}
	}
}