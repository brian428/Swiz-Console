//------------------------------------------------------------------------------
//	Kap IT  -  Copyright 2010 Kap IT  -  All Rights Reserved. 
// 
//    This component is distributed under the GNU LGPL v2.1  
//    (available at : http://www.hnu.org/licences/old-licenses/lgpl-2.1.html) 
//------------------------------------------------------------------------------

package fr.kapit.utils {
	import flash.net.getClassByAlias;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ICollectionView;
	import mx.controls.List;
	
	import org.swizframework.core.ISwiz;
	import org.swizframework.core.SwizManager;

	public class ClassUtils {

		public static function getClassByName(name:String):Class {
			var classz:Class ;
			try {
				classz = getClassByAlias(name);
			} catch (e:Error) {
				try {
					classz = getDomainDefinition(name) as Class;
				} catch (e2:Error) {

				}
			}
			return classz;
		}


		public static function getInstanceLabel(obj:Object):String {
			if (!obj)
				return null;
			var label:String;
			try {
				label = obj.label;
			} catch (e:Error) {

			}
			if (!label) {
				if (obj is Array || obj is ICollectionView || obj is ArrayCollection || obj is List) {
					label = ClassUtils.getShortClassName(obj);
				} else {
					label = obj.toString();
					var idx:int = label.lastIndexOf(".");
					if (idx > 0)
						label = label.substring(idx + 1);
				}
			}
			return label
		}


		public static function getLabelForDisplayNode(obj:Object):String {
			if (!obj)
				return "";
			var type:String = obj.toString();
			if (!type)
				return "";
			var idx:int = type.lastIndexOf(".");
			var shortVarName:String = (idx < 0) ? type : type.substr(idx + 1);
			return shortVarName;
		}

		public static function getMatchingClass(target:*):Class {
			var classz:Class;
			if (target is String)
				classz = getClassByAlias(target);
			else if (target is Class)
				classz = target as Class;
			else
				classz = getObjectClass(target);
			return classz;
		}

		public static function getObjectClass(target:*):Class {
			var classz:Class;
			if (target is int)
				classz = int;
			else if (target is Number)
				classz = Number;
			else if (target == null)
				classz = null;
			else if (target is Class)
				classz = target as Class;
			else if (target is Function)
				classz = Function;
			else {
				var qualified:String = getQualifiedClassName(target);
				try {
					classz = getDomainDefinition(qualified) as Class;
				} catch (e:Error) {
					classz = null;
				}
			}
			return classz;
		}

		public static function getShortClassName(target:*):String {
			var name:String = getQualifiedClassName(target);
			var idx:int = name.indexOf("::");
			if (idx >= 0)
				name = name.substr(idx + 2);
			return name;
		}
		
		public static function getDomainDefinition( name : String ) : Class
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