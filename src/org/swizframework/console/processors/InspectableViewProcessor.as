package org.swizframework.console.processors
{
	import org.swizframework.console.util.InspectionLookup;
	import org.swizframework.core.Bean;
	import org.swizframework.processors.ViewProcessor;
	import org.swizframework.reflection.IMetadataTag;
	import org.swizframework.reflection.MetadataHostMethod;
	import org.swizframework.utils.logging.SwizLogger;

	public class InspectableViewProcessor extends ViewProcessor
	{

		//--------------------------------------
		//   Constructor 
		//--------------------------------------

		public function InspectableViewProcessor( metadataNames : Array = null )
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
			super.tearDownMetadataTags( metadataTags, bean );

			for each( var metadataTag : IMetadataTag in metadataTags )
			{
				var viewType : Class;

				if( InspectionLookup.VIEW_MEDIATORS.length )
				{
					for( var i : int = InspectionLookup.VIEW_MEDIATORS.length - 1; i > -1; i-- )
					{
						var thisInjection : Object = InspectionLookup.VIEW_MEDIATORS[ i ];

						if( thisInjection.metadataTag == metadataTag || ( bean == thisInjection.bean && thisInjection.property == metadataTag.host.name && thisInjection.type == metadataTag.host.type ) )
						{
							InspectionLookup.VIEW_MEDIATORS.removeItemAt( i );
							logger.info( metadataTag.asTag + " torn down on bean: " + bean.toString() );
						}
					}
				}
			}
		}

		//--------------------------------------
		//   Protected Methods 
		//--------------------------------------

		override protected function processViewBean( bean : Bean, tagName : String ) : void
		{
			super.processViewBean( bean, tagName );

			var viewType : Class = bean.typeDescriptor.type;

			// check for any stored refs for this view type
			if( views[ viewType ] )
			{
				var refs : Array = views[ viewType ] as Array;

				for each( var ref : Object in refs )
				{
					if( ref.tag.name != tagName )
						continue;

					if( tagName == VIEW_ADDED )
					{
						var injectData : Object = new Object();
						injectData.bean = ref.mediator;
						injectData.asTag = ref.tag.asTag;
						injectData.property = ref.tag.host.name;
						injectData.type = viewType;
						injectData.metadataTag = ref.tag;
						injectData.value = bean.source;
						InspectionLookup.VIEW_MEDIATORS.addItem( injectData );
						logger.info( "[ViewAdded] processed on bean: " + ref.mediator.toString() );
					}
					else if( tagName == VIEW_REMOVED && InspectionLookup.VIEW_MEDIATORS.length )
					{
						for( var i : int = InspectionLookup.VIEW_MEDIATORS.length - 1; i > -1; i-- )
						{
							var thisViewMediator : Object = InspectionLookup.VIEW_MEDIATORS[ i ];

							if( thisViewMediator.metadataTag == ref.tag || ( ref.mediator == thisViewMediator.bean && thisViewMediator.property == ref.tag.host.name && thisViewMediator.type == ref.tag.host.type ) )
							{
								InspectionLookup.VIEW_MEDIATORS.removeItemAt( i );
								logger.info( "[ViewRemoved] processed on bean: " + ref.mediator.toString() );
							}
						}
					}

				}
			}
		}
	}
}
