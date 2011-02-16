package org.swizframework.console.processors
{
	public dynamic class InspectableMetadataProcessorArray extends Array
	{

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function InspectableMetadataProcessorArray( ... parameters )
		{
			push.apply( this, parameters )
			addProcessors();
		}
		
		protected function addProcessors() : void
		{
			push( new InspectableEventHandlerProcessor() );
			push( new InspectablePostConstructProcessor() );
			push( new InspectableInjectProcessor() );
			push( new InspectablePreDestroyProcessor() );
			push( new InspectableDispatcherProcessor() );
			push( new InspectableSwizInterfaceProcessor() );
			push( new InspectableSwizProcessor() )
		}
	}
}