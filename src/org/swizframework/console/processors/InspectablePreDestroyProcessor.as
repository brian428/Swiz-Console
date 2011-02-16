package org.swizframework.console.processors
{
	import org.swizframework.core.Bean;
	import org.swizframework.processors.PreDestroyProcessor;
	import org.swizframework.utils.logging.SwizLogger;

	public class InspectablePreDestroyProcessor extends PreDestroyProcessor
	{

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function InspectablePreDestroyProcessor( metadataNames : Array = null )
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

		override public function tearDownMetadataTags( metadataTags : Array, bean : Bean ) : void
		{
			super.setUpMetadataTags( metadataTags, bean );
			logger.info( "[PreDestroy] processed on bean: " + bean.toString() );
		}
	}
}