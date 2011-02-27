The Swiz Console (download swc) is an implementation of the Kap Lab debugging console. It offers a number of features that help in building and debugging Swiz-based applications. Note that right now this only works with the 4.x SDK, since building a 3.x SDK version will require conditional compilation to generate separate swcs.

Using the Swiz Console
After you add the swc to your project (typically in the /libs folder), using the console is very straightforward:

In whatever page contains your Swiz configuration (usually Application or WindowedApplication), add the namespaces for the custom metadata processors and the custom logging class:

xmlns:logging="org.swizframework.console.logging.*"
xmlns:processors="org.swizframework.console.processors.*"

Next, modify your Swiz configuration to use the custom logger and processors:

<swiz:Swiz id="mySwiz">
	<swiz:config>
		<swiz:SwizConfig id="mySwizConfig" eventPackages="my.events.*" viewPackages="my.views.*" />
	</swiz:config>
	<swiz:beanProviders>
		<local:Beans />
	</swiz:beanProviders>
	<swiz:loggingTargets>
		<swiz:SwizTraceTarget id="myTraceTarget" />
		<logging:KapITSwizLoggingTarget id="kapITLoggingTarget" />
	</swiz:loggingTargets>
	<swiz:customProcessors>
		<processors:InspectableMetadataProcessorArray />
	</swiz:customProcessors>
</swiz:Swiz>
The custom Array is there as a convenience, to cover most situations. If you have your own custom processors in use already, just add all of the custom Swiz console processors (InspectableDispatcherProcessor, InspectableEventHandlerProcessor, InspectableInjectProcessor, InspectablePostConstructProcessor, InspectablePreDestroyProcessor, InspectableSwizInterfaceProcessor, and InspectableSwizProcessor) individually.

Finally, add an onApplicationComplete handler and initialize the console:

private function onApplicationComplete() : void
{
	var p : SwizConsole = new SwizConsole();
	p.showPopup();
}
If you close the console (or you remove the showPopup() call if you don't want it to show up immediately), you can open the console by doing a control-alt click on the application.