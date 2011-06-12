package com.training.commons.utils
{
	import mx.controls.Alert;
	import mx.controls.Tree;
	
	public class XmlTree extends Tree
	{
		public function loadXml(xml:XML):void
		{
			this.labelField = "@label";
			this.dataProvider = interpretXML(xml);		
		}
		
		private function interpretXML(xml:XML):XML
		{
			var i:int;
			//处理根节点
			var nodeName:String = xml.name();
			
			//简单内容
			if(nodeName == null)
			{
				nodeName = xml.toString();
			}
			else
			//移除命名空间		
			if(nodeName.search("::")>0)
			{
				nodeName = nodeName.substring(nodeName.search("::")+2)
				
			}
			
			var resultXml:XML = new XML("<node label='" + nodeName + "'></node>");
			
 			//处理所有的属性
			var attributesList:XMLList = xml.@*;
			for (i = 0; i < attributesList.length(); i++)
			{ 
				resultXml.appendChild(attributesList[i].name() + " =  "+ attributesList[i]);
			} 
		 
			//处理所有的子节点
			var childrenList:XMLList = xml.children();
			for (i = 0; i < childrenList.length(); i++)
			{ 
			    resultXml.appendChild(interpretXML(childrenList[i]));		
			}
           
			return resultXml;
		}
	}
}