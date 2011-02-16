package org.swizframework.console.processors
{
	import org.swizframework.core.Bean;
	import org.swizframework.core.IBeanFactoryAware;
	import org.swizframework.core.IDispatcherAware;
	import org.swizframework.core.IInitializing;
	import org.swizframework.core.ISwizAware;
	import org.swizframework.processors.SwizInterfaceProcessor;
	import org.swizframework.utils.logging.SwizLogger;

	public class InspectableSwizInterfaceProcessor extends SwizInterfaceProcessor
	{

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function InspectableSwizInterfaceProcessor()
		{
			super();
		}
		
		//--------------------------------------
		//   Private Properties 
		//--------------------------------------
		
		private var logger : SwizLogger = SwizLogger.getLogger( this );

		//--------------------------------------
		//   Public Methods 
		//--------------------------------------

		override public function setUpBean( bean : Bean ) : void
		{
			super.setUpBean( bean );
			
			var obj : * = bean.type;

			if ( obj is ISwizAware )
				logger.info( "ISwizAware processed for bean: " + bean.toString() );
			if ( obj is IBeanFactoryAware )
				logger.info( "IBeanFactoryAware processed for bean: " + bean.toString() );
			if ( obj is IDispatcherAware )
				logger.info( "IDispatcherAware processed for bean: " + bean.toString() );
			if ( obj is IInitializing )
				logger.info( "IInitializing processed for bean: " + bean.toString() );
		}
	}
}