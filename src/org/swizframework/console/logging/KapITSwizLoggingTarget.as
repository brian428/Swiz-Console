package org.swizframework.console.logging
{
	import fr.kapit.logger.KapITLogEvent;
	import fr.kapit.logger.KapITLogger;
	
	import org.swizframework.utils.logging.AbstractSwizLoggingTarget;
	import org.swizframework.utils.logging.SwizLogEvent;
	import org.swizframework.utils.logging.SwizLogger;

	public class KapITSwizLoggingTarget extends AbstractSwizLoggingTarget
	{

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function KapITSwizLoggingTarget()
		{
			super();
		}


		//--------------------------------------
		//   Public Properties 
		//--------------------------------------

		override public function get filters() : Array
		{
			return super.filters;
		}

		override public function set filters( value : Array ) : void
		{
			super.filters = value;
		}

		override public function get level() : int
		{
			return super.level;
		}

		override public function set level( value : int ) : void
		{
			super.level = value;
		}


		//--------------------------------------
		//   Public Methods 
		//--------------------------------------

		override public function addLogger( logger : SwizLogger ) : void
		{
			super.addLogger( logger );
		}

		override public function removeLogger( logger : SwizLogger ) : void
		{
			super.removeLogger( logger );
		}

		//--------------------------------------
		//   Protected Methods 
		//--------------------------------------

		override protected function logEvent( event : SwizLogEvent ) : void
		{
			KapITLogger.getInstance().logEvent( new KapITSwizLogEvent( event ) );
		}

		override protected function logHandler( event : SwizLogEvent ) : void
		{
			super.logHandler( event );
		}
	}
}