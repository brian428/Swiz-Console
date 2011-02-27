package org.swizframework.console.logging
{
	import flash.utils.Dictionary;
	
	import fr.kapit.logger.KapITLogEvent;
	
	import mx.logging.LogEventLevel;
	
	import org.swizframework.utils.logging.SwizLogEvent;

	public class KapITSwizLogEvent extends KapITLogEvent
	{

		public var Target : String;
		
		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function KapITSwizLogEvent( body : SwizLogEvent )
		{
			Target = parseCategoryName( body.target.category );
			super( "Swiz: " + convertLevel( body.level ), body, null );
			this.label = body.message;
		}
		
		private function parseCategoryName( category : String ) : String
		{
			var result : String = "";
			
			if( category )
			{
				var catArray : Array = category.split( '::' );
				
				if( catArray.length > 1 )
				{
					result = catArray[catArray.length - 1];
				}
			}
			
			return result.replace( 'Inspectable', '' );
		}	
		
		
		private function convertLevel( level : int ) : String
		{
			var result : String;
			
			switch( level )
			{
				case LogEventLevel.ALL:
					result = "Log";
					break;
				
				case LogEventLevel.INFO:
					result = "Info";
					break;
				
				case LogEventLevel.DEBUG:
					result = "Debug";
					break;
					
				case LogEventLevel.WARN:
					result = "Warn";
					break;
					
				case LogEventLevel.ERROR:
					result = "Error";
					break;
					
				case LogEventLevel.FATAL:
					result = "Fatal";
					break;	
				
				default:
					result = "Log";
			}
			
			return result;
		}
		
	}
}