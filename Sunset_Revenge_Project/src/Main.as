package
{
	import gamemanager.KongregateManager;
	import gameworld.Credit;
	import gameworld.Landing;
	import gameworld.Level1;
	import gameworld.Opening;
	import gameworld.Preview;
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
		public static var _loader:Loader;
		
		public function Main():void
		{
			super(800, 600, 60);
			FP.console.enable(); FP.console.toggleKey = 188; // Con esto habilito la consola. Se activa con la tecla ',' (coma).
		}
		
		override public function init():void
		{
			FP.screen.color = 0x2c4e68;
			_loader = KongregateManager.GetLoaderUser(root.loaderInfo);
			this.addChild(_loader);
			FP.world = new Level1();
			super.init();
		}
		
		public static function SaveScore():void {
			KongregateManager.SetLoaderScore(_loader);
		}
	}
	
}