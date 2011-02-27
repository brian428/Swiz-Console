package org.swizframework.console.view
{
	import mx.controls.dataGridClasses.DataGridColumn;
	import mx.core.ClassFactory;
	import fr.kapit.console.KapITUniversalInspector;
	import org.swizframework.core.mxml.Swiz;

	public class SwizInspector extends KapITUniversalInspector
	{

		//--------------------------------------
		//   Protected Methods 
		//--------------------------------------

		override protected function _getCustomViews() : Array
		{
			mainTabs.getTabAt( 0 ).label = "Swiz Log";
			eventsView.extraColumns = [ "Target" ];

			var views : Array = [];

			var beansView : BeansView = new BeansView();
			beansView.label = "Beans";
			beansView.toolTip = "Show the Beans that the Swiz BeanFactory is managing.";
			views.push( beansView );

			var injectionsView : InjectionsView = new InjectionsView();
			injectionsView.label = "Injections";
			injectionsView.toolTip = "Show the [Inject] tags which Swiz has set up.";
			views.push( injectionsView );

			var eventHandlerView : EventHandlerView = new EventHandlerView();
			eventHandlerView.label = "EventHandlers";
			eventHandlerView.toolTip = "Show the [EventHandler] tags which Swiz has set up.";
			views.push( eventHandlerView );

			var eventFlowView : EventFlowView = new EventFlowView();
			eventFlowView.label = "Event Flow";
			eventFlowView.toolTip = "Show the [EventHandler] tags being invoked by Swiz.";
			views.push( eventFlowView );

			var swizView : SwizInstanceView = new SwizInstanceView();
			swizView.label = "Swiz Instances";
			swizView.toolTip = "Show the Swiz instances used by this application.";
			views.push( swizView );

			var swizWiredViews : SwizViewsWiredView = new SwizViewsWiredView();
			swizWiredViews.label = "Wired Views";
			swizWiredViews.toolTip = "Show the views that have been wired by Swiz.";
			views.push( swizWiredViews );

			return views;
		}

		override protected function commitProperties() : void
		{
			super.commitProperties();

			var eventGridColumns : Array = [];

			if ( eventsView && eventsView.eventsComponent && eventsView.eventsComponent.eventsGrid )
			{
				eventGridColumns = eventsView.eventsComponent.eventsGrid.columns;
			}

			if ( eventGridColumns.length > 2 )
			{
				DataGridColumn( eventGridColumns[ 0 ] ).width = 20;
				DataGridColumn( eventGridColumns[ 0 ] ).itemRenderer = new ClassFactory( LogLevelDataGridRenderer );
				DataGridColumn( eventGridColumns[ 1 ] ).width = 100;
				DataGridColumn( eventGridColumns[ 1 ] ).itemRenderer = new ClassFactory( LogLevelDataGridRenderer );
				DataGridColumn( eventGridColumns[ 2 ] ).itemRenderer = new ClassFactory( LogLevelDataGridRenderer );

				if ( eventGridColumns.length > 3 )
				{
					DataGridColumn( eventGridColumns[ 3 ] ).width = 200;
					DataGridColumn( eventGridColumns[ 3 ] ).itemRenderer = new ClassFactory( LogLevelDataGridRenderer );
				}
			}
		}
	}
}