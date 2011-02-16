package org.swizframework.console.processors
{
	import org.swizframework.console.logging.KapITSwizLogger;
	import org.swizframework.core.Bean;
	import org.swizframework.processors.PostConstructProcessor;
	import org.swizframework.utils.logging.SwizLogger;

	public class InspectablePostConstructProcessor extends PostConstructProcessor
	{

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function InspectablePostConstructProcessor( metadataNames : Array = null )
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
			logger.info( "[PostConstruct] processed on bean: " + bean.toString() );
		}
	}
}