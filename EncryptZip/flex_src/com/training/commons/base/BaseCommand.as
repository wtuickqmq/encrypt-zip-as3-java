package com.training.commons.base
{
	import com.universalmind.cairngorm.commands.*;
	import com.universalmind.cairngorm.events.Callbacks;
	import com.training.demo.control.delegates.DemoDelegate;
	public class BaseCommand extends Command
	{

        private var SYS_SESSION:Number = 1200000;
        
		
		
		protected function login(event:BaseEvent):void {			
		
			var handlers:Callbacks = new Callbacks(login_result);
			getDelegate(handlers).login(event.dataObject);
		}
		
		protected function login_result(data:*):void {
		
		}
		protected function saveOrUpdate(event:BaseEvent):void {			
		
			var handlers:Callbacks = new Callbacks(saveOrUpdate_result);
			getDelegate(handlers).saveOrUpdate(event.dataObject);
		}
		
		protected function saveOrUpdate_result(data:*):void {
		
		}
		
		protected function downloadFile(event:BaseEvent):void {			
		
			var handlers:Callbacks = new Callbacks(downloadFile_result);
			getDelegate(handlers).downloadFile(event.dataObject);
		}
		
		protected function downloadFile_result(data:*):void {
		
		}
		protected function uploadFile(event:BaseEvent):void {			
		
			var handlers:Callbacks = new Callbacks(uploadFile_result);
			getDelegate(handlers).uploadFile(event.dataObject);
		}
		
		protected function uploadFile_result(data:*):void {
		
		}
		
				
		
        protected function getDelegate(handlers:Callbacks):BaseDelegate {
	        	var delegate : BaseDelegate  = new DemoDelegate( handlers );
	        	return delegate;
		}
			
		
	}
}