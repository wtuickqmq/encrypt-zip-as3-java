
package com.universalmind.cairngorm.vo
{
	import flash.utils.ByteArray;
	/*
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
	import flash.net.registerClassAlias;
	*/
	public class ValueObject 
	{
		
		
		public function ValueObject() {		
		                             	
		}	
		
		/*TypeError: Error #1034:
		*when the sub-class of ValueObject has a special constructor definitions,
		* #1034 will happen during performs copier.readObject() after used registerClassAlias		
		*/
		public function clone():Object {

            /* 
			var typeName:String = getQualifiedClassName(this);
			var packageName:String = typeName.split("::")[0];
			var type:Class = getDefinitionByName(typeName) as Class;
			registerClassAlias(packageName, type);             
            */
            var copier:ByteArray = new ByteArray();
            copier.writeObject(this);
            copier.position = 0;            
            return copier.readObject();
			
		}
		
	    public function fill(obj:Object):void {
	        for (var key:String in obj)
	        {
	            this[key] = obj[key];
	        }
	    }
		
	
	}
}
