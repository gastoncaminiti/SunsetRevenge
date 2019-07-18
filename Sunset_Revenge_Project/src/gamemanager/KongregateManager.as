package gamemanager 
{
	import flash.display.LoaderInfo;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.system.Security;
	
	public class KongregateManager 
	{
		
		private static var paramObj:Object;
		private static var apiPath:String;
		private static var request:URLRequest;
		private static var loader:Loader;
		private static var kongregate:*;
		
		public static function GetLoaderUser(Info:Object):Loader
		{
			paramObj = LoaderInfo(Info).parameters;
			apiPath = paramObj.kongregate_api_path || "http://cdn1.kongregate.com/flash/API_AS3_Local.swf";
			Security.allowDomain(apiPath);
			Security.allowInsecureDomain(apiPath);
			request = new URLRequest(apiPath);
			loader 	= new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, get_user_data);
			loader.load(request);
			return loader;
		}
		
		public static function get_user_data(event:Event):void
		{
			kongregate = event.target.content;
			kongregate.services.connect();
			if (!kongregate.services.isGuest()) {
				 DataManager.set_username(kongregate.services.getUsername());
				 DataManager.set_iduser(kongregate.services.getUserId());
			}else {
				trace("Usuario Invitado - No se pueden obtener datos del usuario")
			}
			
		}
		
		public static function SetLoaderScore(l:Loader):void {
			l.contentLoaderInfo.addEventListener(Event.COMPLETE, set_user_score);
			l.load(request);
		}
		
		public static function set_user_score(event:Event):void
		{
			kongregate = event.target.content;
			kongregate.services.connect();
			if (!kongregate.services.isGuest()) {
				kongregate.stats.submit("HighScore", DataManager.getScore());
			}else {
				trace("Usuario Invitado - No se puede registrar las estadisticas")
				//kongregate.stats.submit("HighScore", DataManager.getScore()); For Shadow Valid
			}
			
		}
	}
}