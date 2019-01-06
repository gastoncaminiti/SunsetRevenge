package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	
	/* Kongrate Prueba */
	import flash.display.LoaderInfo;
	import flash.display.Loader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import flash.system.Security;
	
	/**
	 * ...
	 * @author Caminiti Gastón
	*/
	
	[SWF(width = "800", height = "600")]
	
	public class Main extends Engine 
	{
		private var kongregate:*;
		
		public function Main():void
		{
			initKongregateAPI();
			
			super(800, 600, 30, false);
			
			FP.screen.color = 0x000fff;
			
			FP.world = new GameWorld();
			
			FP.console.enable(); FP.console.toggleKey = 188; // Con esto habilito la consola. Se activa con la tecla ',' (coma).
		}
		
	
		private function loadComplete(event:Event):void {
			// Save Kongregate API reference
			kongregate = event.target.content;
				 
			// Connect to the back-end
			kongregate.services.connect();
			trace(kongregate.loaderInfo.url);
			kongregate.stats.submit("Total Clicks", 1);
			kongregate.stats.submit("Max Clicks", 5);
			kongregate.stats.submit("Last X", 6);
					 
			// You can now access the API via:
			// kongregate.services
			// kongregate.user
			// kongregate.scores
			// kongregate.stats
			// etc...
		}
		
		private function initKongregateAPI():void {
			// Pull the API path from the FlashVars
			var paramObj:Object = LoaderInfo(root.loaderInfo).parameters;
					 
			// The API path. The "shadow" API will load if testing locally. 
			var apiPath:String = paramObj.kongregate_api_path || 
			"http://www.kongregate.com/flash/API_AS3_Local.swf";
					 
			// Allow the API access to this SWF
			Security.allowDomain(apiPath);
					 
			// Load the API
			var request:URLRequest = new URLRequest(apiPath);
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplete);
			loader.load(request);
			this.addChild(loader);          
			trace("A");
		}
		
	}
	
}