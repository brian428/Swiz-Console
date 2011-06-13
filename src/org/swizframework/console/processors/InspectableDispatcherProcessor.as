package org.swizframework.console.processors
{
	import org.swizframework.core.Bean;
	import org.swizframework.processors.DispatcherProcessor;
	import org.swizframework.utils.logging.SwizLogger;

	public class InspectableDispatcherProcessor extends DispatcherProcessor
	{

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function InspectableDispatcherProcessor( metadataNames : Array = null )
		{
			super( metadataNames );
		}

		//--------------------------------------
		//   Private Properties 
		//--------------------------------------

		private var logger : SwizLogger = SwizLogger.getLogger( this );

		//--------------------------------------
		//   Public Methods 
		//--------------------------------------

		override public function setUpMetadataTags( metadataTags : Array, bean : Bean ) : void
		{
			super.setUpMetadataTags( metadataTags, bean );
			if( metadataTags.length > 0 )
			{
				logger.info( "[Dispatcher] injected to bean: " + bean.toString() );
			}	
		}
	}
}