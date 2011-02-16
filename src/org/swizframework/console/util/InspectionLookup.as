package org.swizframework.console.util
{
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	
	import org.swizframework.core.SwizManager;

	public class InspectionLookup
	{

		//--------------------------------------
		//   Static Properties 
		//--------------------------------------

		[Bindable]
		public static var BEAN_LIST : ArrayCollection = new ArrayCollection();

		[Bindable]
		public static var EVENT_HANDLER_FLOW : ArrayCollection = new ArrayCollection();

		[Bindable]
		public static var EVENT_HANDLER_LIST : ArrayCollection = new ArrayCollection();

		[Bindable]
		public static var INJECTIONS : ArrayCollection = new ArrayCollection();
		
		[Bindable]
		public static var SWIZ_INSTANCES : ArrayCollection = new ArrayCollection();
		
		[Bindable]
		public static var WIRED_VIEWS : ArrayCollection = new ArrayCollection();
		
		public static function updateWiredViews() : void
		{
			WIRED_VIEWS.source = [];
			
			for( var thisView : Object in SwizManager.wiredViews )
			{
				WIRED_VIEWS.addItem( thisView );
			}
		}
		
		[Bindable]
		private static var BEAN_LISTS : ArrayCollection = new ArrayCollection();
		
	  	public static function addBeanList( beans : Array ) : void
		{
			BEAN_LISTS.addEventListener( CollectionEvent.COLLECTION_CHANGE, InspectionLookup.updateBeanList );
			
			var beanCollection : ArrayCollection = new ArrayCollection( beans );
			beanCollection.addEventListener( CollectionEvent.COLLECTION_CHANGE, InspectionLookup.updateBeanList );
			BEAN_LISTS.addItem( beanCollection );
		}
		
		public static function updateBeanList( event : CollectionEvent=null ) : void
		{
			BEAN_LIST.removeAll();
			
			for each( var thisBeanList : ArrayCollection in BEAN_LISTS )
			{
				BEAN_LIST.addAll( thisBeanList );
			}
			
			BEAN_LIST.refresh();
		}
		
	}
}