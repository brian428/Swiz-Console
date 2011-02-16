package org.swizframework.console
{
	import fr.kapit.popup.PopupLoader;
	
	import org.swizframework.console.view.SwizConsoleView;
	
	public class SwizConsole extends PopupLoader
	{
		public static const NAME:String = "SwizConsole";
		
		public function SwizConsole()
		{
			super( NAME, SwizConsoleView );
		}
		
	}
}