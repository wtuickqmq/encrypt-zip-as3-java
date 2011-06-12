package com.training.commons.utils
{
	import com.training.manifest.model.vo.ManifestMessageHead;
	import com.training.transport.model.vo.TransportHead;
    import mx.utils.UIDUtil;
	
	public class ManifestUtil
	{

        public static function getManifestFileName(manifestMessageHead:ManifestMessageHead):String{
  	
  	        var date:Date = new Date();

            return "CN_" + manifestMessageHead.messageType + "_" + "1p0" + "_" + manifestMessageHead.senderId + "_" + date.getFullYear() 
                + formatNumberWithChar(date.getMonth()+1,2,"0") + formatNumberWithChar(date.getDate(),2,"0") 
                + formatNumberWithChar(date.getHours(),2,"0") + formatNumberWithChar(date.getMinutes(),2,"0") + date.getMilliseconds();
       }
       public static function getTransportFileName(transportHead:TransportHead):String{
  	
  	        var date:Date = new Date();

            return "CN_" + transportHead.messageType + "_" + "1p0" + "_" + transportHead.senderId + "_" + date.getFullYear() 
                + formatNumberWithChar(date.getMonth()+1,2,"0") + formatNumberWithChar(date.getDate(),2,"0") 
                + formatNumberWithChar(date.getHours(),2,"0") + formatNumberWithChar(date.getMinutes(),2,"0") + date.getMilliseconds();
       }
       
       public static function getManifestMessageId(manifestMessageHead:ManifestMessageHead):String{
           return UIDUtil.createUID();
       }
       
       public static function getTransportMessageId(transportHead:TransportHead):String{
           return UIDUtil.createUID();
       }
       
       
       public static function getManifestVersion(manifestMessageHead:ManifestMessageHead):String{
           return "1.0";
       }
       
       public static function getTransportVersion(transportHead:TransportHead):String{
       
           return "1.0";
       }
       
       
       private static function formatNumberWithChar(value:Number,length:int=2,pref:String="0"):String{
            var str:String=new String(value);
            var len:int=str.length;
            
            if(len>length)
                return str.substr(0,length);
            else{
                var n:int=length-len;
                for(var i:int=0;i<n; i++) {
                    str=pref+str;
                }
                return str;
            }
        }
       
       
       
	}
}