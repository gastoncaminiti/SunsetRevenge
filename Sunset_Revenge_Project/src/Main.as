package
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Caminiti Gastón
	 */
	
	[SWF(width = "800", height = "600")]
	
	public class Main extends Engine 
	{
		
		public function Main():void
		{
			super(800, 600, 30, false);
			
			FP.screen.color = 0x000fff;
			
			//FP.world = new Portal();
			
			//FP.console.enable(); FP.console.toggleKey = 188; // Con esto habilito la consola. Se activa con la tecla ',' (coma).
		}
		
	}
	
}