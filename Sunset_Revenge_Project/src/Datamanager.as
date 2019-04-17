package 
{
	public class Datamanager 
	{
		private static var _highScore:int = 10;
	
		public static function getScore():int {
			return _highScore;
		}
		
		public static function addScore(v:int):void {
			_highScore += v;
		}
	}
}