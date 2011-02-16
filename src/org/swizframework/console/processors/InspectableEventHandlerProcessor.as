package org.swizframework.console.processors
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.utils.Dictionary;
	
	import fr.kapit.utils.stack.CallStack;
	
	import mx.collections.ArrayCollection;
	
	import org.swizframework.core.Bean;
	import org.swizframework.core.SwizConfig;
	import org.swizframework.metadata.EventHandlerMetadataTag;
	import org.swizframework.processors.EventHandlerProcessor;
	import org.swizframework.reflection.IMetadataTag;
	import org.swizframework.utils.event.EventHandler;

	public class InspectableEventHandlerProcessor extends EventHandlerProcessor
	{

		//--------------------------------------
		//   Static Properties 
		//--------------------------------------

		public static var EVENT_HANDLER_BEANS : Dictionary = new Dictionary( true );

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function InspectableEventHandlerProcessor( metadataNames : Array = null )
		{
			super( metadataNames );
		}


		//--------------------------------------
		//   Public Methods 
		//--------------------------------------


		override public function setUpMetadataTag( metadataTag : IMetadataTag, bean : Bean ) : void
		{
			super.setUpMetadataTag( metadataTag, bean );
			
			EVENT_HANDLER_BEANS[ bean.source[ metadataTag.host.name ] ] = bean.source;

			var inspectionData : Object = new Object();
			inspectionData.bean = bean.source;
			inspectionData.handlerName = metadataTag.host.name;
			inspectionData.tag = metadataTag.asTag;
			InspectionLookup.EVENT_HANDLER_LIST.addItem( inspectionData );
		}


		override public function tearDownMetadataTag( metadataTag : IMetadataTag, bean : Bean ) : void
		{
			super.tearDownMetadataTag( metadataTag, bean );
			
			var eventHandlerList : ArrayCollection = InspectionLookup.EVENT_HANDLER_LIST;
			
			for( var i:int = eventHandlerList.length - 1; i > -1; i-- )
			{
				var thisHandler : Object = eventHandlerList[ i ];
				
				if( thisHandler.bean == bean.source && thisHandler.handlerName == metadataTag.host.name && thisHandler.tag == metadataTag.asTag )
				{
					eventHandlerList.removeItemAt( i );
				}
			}
		}

		//--------------------------------------
		//   Protected Methods 
		//--------------------------------------

		override protected function addEventHandlerByEventType( eventHandlerTag : EventHandlerMetadataTag, method : Function, eventClass : Class, eventType : String ) : void
		{
			super.addEventHandlerByEventType( eventHandlerTag, method, eventClass, eventType );

			var dispatcher : IEventDispatcher = null;

			// if the eventHandler tag defines a scope, set proper dispatcher, else use defaults
			if ( eventHandlerTag.scope == SwizConfig.GLOBAL_DISPATCHER )
				dispatcher = swiz.globalDispatcher;
			else if ( eventHandlerTag.scope == SwizConfig.LOCAL_DISPATCHER )
				dispatcher = swiz.dispatcher;
			else
				dispatcher = swiz.config.defaultDispatcher == SwizConfig.LOCAL_DISPATCHER ? swiz.dispatcher : swiz.globalDispatcher;

			dispatcher.addEventListener( eventType, handleEvent, eventHandlerTag.useCapture, eventHandlerTag.priority + 1, true );
		}

		override protected function removeEventHandlerByEventType( eventHandlerTag : EventHandlerMetadataTag, method : Function, eventClass : Class, eventType : String ) : void
		{
			super.removeEventHandlerByEventType( eventHandlerTag, method, eventClass, eventType );
			
			var dispatcher : IEventDispatcher = null;
			
			// if the eventHandler tag defines a scope, set proper dispatcher, else use defaults
			if ( eventHandlerTag.scope == SwizConfig.GLOBAL_DISPATCHER )
				dispatcher = swiz.globalDispatcher;
			else if ( eventHandlerTag.scope == SwizConfig.LOCAL_DISPATCHER )
				dispatcher = swiz.dispatcher;
			else
				dispatcher = swiz.config.defaultDispatcher == SwizConfig.LOCAL_DISPATCHER ? swiz.dispatcher : swiz.globalDispatcher;
			
			dispatcher.removeEventListener( eventType, handleEvent, eventHandlerTag.useCapture );
		}

		//--------------------------------------
		//   Private Methods 
		//--------------------------------------

		private function handleEvent( event : Event ) : void
		{
			// get array of EventHandler objects for this type
			var eventHandlersForType : Array = eventHandlersByEventType[ event.type ];

			var inspectionData : Object = new Object();

			// loop over event handlers for this type...
			for ( var thisHandler : uint = 0; thisHandler < eventHandlersForType.length; thisHandler++ )
			{
				var eventHandler : EventHandler = eventHandlersForType[ thisHandler ] as EventHandler;

				// if the Event class matches the Event Class for the current handler
				if ( event is eventHandler.eventClass )
				{
					inspectionData.eventClass = eventHandler.eventClass;
					inspectionData.eventTypeLiteral = event.type;
					inspectionData.tag = eventHandler.metadataTag.asTag;
					inspectionData.handlerName = eventHandler.metadataTag.host.name;
					inspectionData.handlerArgNames = eventHandler.metadataTag.args;
					inspectionData.bean = EVENT_HANDLER_BEANS[ eventHandler.method ];
					inspectionData.event = event;
					inspectionData.callStack = new CallStack();
					
					/*if( InspectionLookup.EVENT_HANDLER_FLOW.length == 0 || InspectionLookup.EVENT_HANDLER_FLOW.getItemAt( InspectionLookup.EVENT_HANDLER_FLOW.length - 1 ) != inspectionData )
					{
						inspectionData.number = InspectionLookup.EVENT_HANDLER_FLOW.length + 1;
						InspectionLookup.EVENT_HANDLER_FLOW.addItem( inspectionData );
					}	*/
					if( !InspectionLookup.EVENT_HANDLER_FLOW.contains( inspectionData ) )
					{
						inspectionData.number = InspectionLookup.EVENT_HANDLER_FLOW.length + 1;
						InspectionLookup.EVENT_HANDLER_FLOW.addItem( inspectionData );
					}	
				}
			}
			
			var temp : Boolean = true;
		}
	}
}