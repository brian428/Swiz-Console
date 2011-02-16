package org.swizframework.console.view
{
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
		
	}
}