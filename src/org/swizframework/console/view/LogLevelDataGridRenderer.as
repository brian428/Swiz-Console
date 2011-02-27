package org.swizframework.console.view
{
	import flash.display.Graphics;
	import mx.controls.DataGrid;
	import mx.controls.Label;
	import mx.controls.dataGridClasses.DataGridListData;

	public class LogLevelDataGridRenderer extends Label
	{

		//--------------------------------------
		//   Protected Methods 
		//--------------------------------------

		override protected function updateDisplayList( unscaledWidth : Number, unscaledHeight : Number ) : void
		{
			super.updateDisplayList( unscaledWidth, unscaledHeight );
			
			var g : Graphics = graphics;
			g.clear();
			
			if ( data.notificationType  == 'Swiz: Warn' )
			{
				g.beginFill( 0xFFFF00 );
				g.drawRect( 0, 0, unscaledWidth, unscaledHeight );
				g.endFill();
			}
			else if ( data.notificationType == 'Swiz: Error' || data.notificationType == 'Swiz: Fatal' )
			{
				g.beginFill( 0xFF3300 );
				g.drawRect( 0, 0, unscaledWidth, unscaledHeight );
				g.endFill();
			}
			
		}
	}
}