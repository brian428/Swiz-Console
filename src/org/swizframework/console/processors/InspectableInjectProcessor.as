package org.swizframework.console.processors
{
	import mx.binding.utils.ChangeWatcher;
	import mx.utils.ObjectUtil;
	import mx.utils.UIDUtil;
	
	import org.swizframework.core.Bean;
	import org.swizframework.metadata.InjectMetadataTag;
	import org.swizframework.processors.InjectProcessor;
	import org.swizframework.reflection.IMetadataTag;
	import org.swizframework.console.util.InspectionLookup;

	public class InspectableInjectProcessor extends InjectProcessor
	{

		//--------------------------------------
		//   Public Methods 
		//--------------------------------------

		override public function setUpMetadataTag( metadataTag : IMetadataTag, bean : Bean ) : void
		{
			var injectData : Object = new Object();
			injectData.bean = bean;
			injectData.asTag = metadataTag.asTag;
			injectData.property = metadataTag.host.name;
			injectData.type = metadataTag.host.type;
			injectData.metadataTag = metadataTag;
			InspectionLookup.INJECTIONS.addItem( injectData );
			
			super.setUpMetadataTag( metadataTag, bean );
		}

		override public function tearDownMetadataTag( metadataTag : IMetadataTag, bean : Bean ) : void
		{
			super.tearDownMetadataTag( metadataTag, bean );
			
			if( InspectionLookup.INJECTIONS.length )
			{
				for ( var i : int = InspectionLookup.INJECTIONS.length - 1; i > -1; i-- )
				{
					var thisInjection : Object = InspectionLookup.INJECTIONS[ i ];
	
					if ( thisInjection.metadataTag == metadataTag || ( bean.source == thisInjection.bean.source && thisInjection.property == metadataTag.host.name && thisInjection.type == metadataTag.host.type ) )
					{
						InspectionLookup.INJECTIONS.removeItemAt( i );
					}
				}
			}	
		}

		//--------------------------------------
		//   Protected Methods 
		//--------------------------------------

		override protected function addPropertyBinding( destObject : Object, destPropName : String, sourceObject : Object, sourcePropertyChain : Array, twoWay : Boolean = false ) : void
		{
			super.addPropertyBinding( destObject, destPropName, sourceObject, sourcePropertyChain, twoWay );
			
			var temp:Object = InspectionLookup.INJECTIONS;
			
			var changeWatcher : ChangeWatcher;
			var uid : String = UIDUtil.getUID( destObject );

			if ( injectByProperty[ uid ] && injectByProperty[ uid ].length )
			{
				changeWatcher = injectByProperty[ uid ][ injectByProperty[ uid ].length - 1 ] as ChangeWatcher;
			}

			var injectData : Object = findInjectData( destObject, destPropName );
			injectData.value = destObject[destPropName];
			injectData.changeWatcher = changeWatcher;
		}

		override protected function setDestinationValue( injectTag : InjectMetadataTag, bean : Bean, value : * ) : void
		{
			super.setDestinationValue( injectTag, bean, value );
			
			var injectData : Object = findInjectData( bean.source, injectTag.host.name );
			injectData.value = value;
			injectData.changeWatcher = "None (injection does not use bind='true')";
		}

		//--------------------------------------
		//   Private Methods 
		//--------------------------------------

		private function findInjectData( target : Object, propertyName : String ) : Object
		{
			var result : Object;

			for each ( var thisData : Object in InspectionLookup.INJECTIONS )
			{
				if ( thisData.bean.source == target && thisData.property == propertyName )
				{
					result = thisData;
				}
			}

			return result;
		}
	}
}