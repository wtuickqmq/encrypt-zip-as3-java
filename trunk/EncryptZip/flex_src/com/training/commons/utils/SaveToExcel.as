package com.training.commons.utils
{
        import mx.collections.ArrayCollection;
	    import flash.net.*;
		import mx.collections.*;
		import mx.rpc.events.ResultEvent;
		import mx.controls.*;
	public class SaveToExcel{
		
		 public static  var urlExcelExport:String = "./print/excelexport.jsp";
		 
		 public static function convertDGToHTMLTable(dg:DataGrid):String {
	        	var font:String = "宋体";
	        	var size:String = dg.getStyle('fontSize');
	        	var str:String = '';
	        	var colors:String = '';
	        	var style:String = 'style="font-family:'+font+';font-size:'+size+'pt;"';				
	        	var hcolor:Array;
	        	if(dg.getStyle("headerColor") != undefined) {
	        		hcolor = [dg.getStyle("headerColor")];
	        	} else {
	        		hcolor = dg.getStyle("headerColors");
	        	}				
	        	str+='<table width="'+dg.width+'"><thead><tr width="'+dg.width+'" style="background-color:#' +Number((hcolor[0])).toString(16)+'">';		
	        	for(var i:int = 0;i<dg.columns.length;i++) {
	        		colors = dg.getStyle("themeColor");
	        			
	        		if(dg.columns[i].headerText != undefined) {
	        			str+="<th "+style+">"+dg.columns[i].headerText+"</th>";
	        		} else {
	        			str+= "<th "+style+">"+dg.columns[i].dataField+"</th>";
	        		}
	        	}
	        	str += "</tr></thead><tbody>";
	        	colors = dg.getStyle("alternatingRowColors");
	        	for(var j:int =0;j<dg.dataProvider.length;j++) {					
	        		str+="<tr width=\""+Math.ceil(dg.width)+"\">";			
	        		for(var k:int=0; k < dg.columns.length; k++) {					
	        			if(dg.dataProvider.getItemAt(j) != undefined && dg.dataProvider.getItemAt(j) != null) {
	        				if(dg.columns[k].labelFunction != undefined) {
	        					str += "<td width=\""+Math.ceil(dg.columns[k].width)+"\" "+style+">"+dg.columns[k].labelFunction(dg.dataProvider.getItemAt(j),dg.columns[k])+"</td>"; 					
	        				} else {
	        					str += "<td width=\""+Math.ceil(dg.columns[k].width)+"\" "+style+">"+dg.dataProvider.getItemAt(j)[dg.columns[k].dataField]+"</td>";
	        				}
	        			}
	        		}
	        		str += "</tr>";
	        	}
	        	str+="</tbody></table>";
	        	return str;
	        }
	    public static   function loadDGInExcel(dg:DataGrid):void {
				var variables:URLVariables = new URLVariables(); 
				variables.htmltable	= convertDGToHTMLTable(dg);
				var u:URLRequest = new URLRequest(urlExcelExport);
				u.data = variables; 
				u.method = URLRequestMethod.POST; 
	            navigateToURL(u,"_self");
	   } 
	} 
       
}  
