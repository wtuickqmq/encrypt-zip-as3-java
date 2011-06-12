package com.training.demo.control.events
{
	import com.training.commons.base.BaseEvent
	import com.universalmind.cairngorm.events.Callbacks;
	
	public class DemoEvent extends BaseEvent
	{
	    public static const EVENT_LOGIN:String = "loginEvent";
	    public static const EVENT_SAVE:String = "saveEvent";
	    public static const EVENT_UPLOAD:String = "UpLoadEvent";
	    public static const EVENT_DOWNLOAD:String = "DownLoadEvent";
		
		//构造器
	    public function DemoEvent(eventType:String, dataObject:Object=null, handlers:Callbacks=null) {
			  super(eventType,dataObject,handlers);
		}
	}
}