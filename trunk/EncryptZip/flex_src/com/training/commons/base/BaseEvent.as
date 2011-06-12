package   com.training.commons.base
{
	import com.universalmind.cairngorm.events.UMEvent;
	import com.universalmind.cairngorm.events.Callbacks;
	
	import flash.events.Event;
	public class BaseEvent extends UMEvent {
		
        public var dataObject:*= null;
        
		public function BaseEvent (eventType:String,dataObject:*=null,handlers:Callbacks=null) 
		{
			  super(eventType,handlers,true, false);
			  
	          this.dataObject = dataObject;
		}
		
		override public function clone():Event  {
			return new BaseEvent(this.type,this.dataObject).copyFrom( this );
		}
		
		override public function copyFrom(src : Event):Event {
			this.dataObject = (src as BaseEvent).dataObject;	
			return this;
		}
		
		override public function toString():String {
			return super.toString();
		}
	}
}