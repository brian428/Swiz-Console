package org.swizframework.console.logging
{
	import fr.kapit.logger.KapITLogEvent;
	
	import org.swizframework.utils.logging.SwizLogEvent;

	public class KapITSwizLogEvent extends KapITLogEvent
	{

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function KapITSwizLogEvent( body : SwizLogEvent )
		{
			super( "Swiz: " + body.type, body, null );
			this.label = body.message;
		}
	}
}