package org.swizframework.console.logging
{
	import fr.kapit.logger.KapITLogEvent;
	import fr.kapit.logger.KapITLogger;
	import org.swizframework.utils.logging.SwizLogger;

	public class KapITSwizLogger extends SwizLogger
	{

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function KapITSwizLogger( className : String )
		{
			super( className );
		}

		//--------------------------------------
		//   Public Methods 
		//--------------------------------------

		override public function debug( msg : String, ... parameters ) : void
		{
			super.debug( msg, parameters );
			KapITLogger.getInstance().logEvent( new KapITLogEvent( "Debug", parameters, null ) );
		}

		override public function error( msg : String, ... parameters ) : void
		{
			super.error( msg, parameters );
			KapITLogger.getInstance().logEvent( new KapITLogEvent( "Error", parameters, null ) );
		}

		override public function fatal( msg : String, ... parameters ) : void
		{
			super.fatal( msg, parameters );
			KapITLogger.getInstance().logEvent( new KapITLogEvent( "Fatal", parameters, null ) );
		}

		override public function info( msg : String, ... parameters ) : void
		{
			super.info( msg, parameters );
			KapITLogger.getInstance().logEvent( new KapITLogEvent( "Info", parameters, null ) );
		}

		override public function log( level : int, msg : String, ... parameters ) : void
		{
			super.log( level, msg, parameters );
			KapITLogger.getInstance().logEvent( new KapITLogEvent( "Log", parameters, null ) );
		}

		override public function warn( msg : String, ... parameters ) : void
		{
			super.warn( msg, parameters );
			KapITLogger.getInstance().logEvent( new KapITLogEvent( "Warn", parameters, null ) );
		}
	}
}