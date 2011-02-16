package org.swizframework.console.processors
{
	import org.swizframework.core.ISwiz;
	import org.swizframework.core.SwizManager;
	import org.swizframework.processors.BaseMetadataProcessor;
	import org.swizframework.console.util.InspectionLookup;

	public class InspectableSwizProcessor extends BaseMetadataProcessor
	{

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function InspectableSwizProcessor( metadataNames : Array = null, metadataClass : Class = null )
		{
			super( metadataNames, metadataClass );
		}

		//--------------------------------------
		//   Public Methods 
		//--------------------------------------

		override public function init( swiz : ISwiz ) : void
		{
			super.init( swiz );
			InspectionLookup.addBeanList( beanFactory.beans );
			InspectionLookup.SWIZ_INSTANCES.source = SwizManager.swizzes;
		}
		
		
	}
}