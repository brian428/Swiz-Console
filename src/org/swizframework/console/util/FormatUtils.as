package org.swizframework.console.util
{
	public class FormatUtils
	{
		
		public static function formatUID( item : Object, frontLength : int, endLength : int ) : String
		{
			var uid : String = item.toString();
			var result : String = uid;
			var uidArray : Array = uid.split( '.' );
			
			if( uidArray.length > ( frontLength + endLength + 1 ) )
			{
				var shortUidEnd : String = uidArray.slice( uidArray.length - endLength, uidArray.length ).join( '.' );
				var shrotUidStart : String = uidArray.slice( 0, frontLength ).join( '.' );
				result = shrotUidStart + '...' + shortUidEnd;
			}
			
			return result;
		}
		
	}
}