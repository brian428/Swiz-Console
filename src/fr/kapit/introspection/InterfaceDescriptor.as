//------------------------------------------------------------------------------
//	Kap IT  -  Copyright 2010 Kap IT  -  All Rights Reserved. 
// 
//    This component is distributed under the GNU LGPL v2.1  
//    (available at : http://www.hnu.org/licences/old-licenses/lgpl-2.1.html) 
//------------------------------------------------------------------------------

package fr.kapit.introspection {
	import flash.utils.getDefinitionByName;
	
	import org.swizframework.core.ISwiz;
	import org.swizframework.core.SwizManager;

	public class InterfaceDescriptor extends AbstractTypeElement {
		public function InterfaceDescriptor(name:String, fromClassExplorerXML:Boolean = false) {
			super(name);
			if (!fromClassExplorerXML)
				_type = getDomainDefinition(name) as Class;
		}

		override public function get type():Class {
			if (!_type)
				_type = getDomainDefinition(name) as Class;

			return _type;
		}
		
		private function getDomainDefinition( name : String ) : Class
		{
			var result : Class;
			
			for each( var thisSwiz : ISwiz in SwizManager.swizzes )
			{
				if( thisSwiz.domain.hasDefinition( name ) )
				{
					result = thisSwiz.domain.getDefinition( name ) as Class;
					break;
				}
			}
			
			if( !result )
			{
				result = getDefinitionByName(name) as Class;
			}
			
			return result;
		}
		
	}
}