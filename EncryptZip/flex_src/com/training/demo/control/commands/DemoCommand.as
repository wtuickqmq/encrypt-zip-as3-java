package com.training.demo.control.commands
{        
    import com.adobe.cairngorm.control.CairngormEvent;
    import com.training.commons.base.BaseCommand;
    import com.training.demo.control.events.DemoEvent;
    import com.training.demo.model.DemoModel;
    import com.training.demo.model.vo.HashData;
    import com.training.demo.model.vo.User;
    
    import flash.utils.ByteArray;
    
    import mx.controls.Alert;
    
	public class DemoCommand  extends BaseCommand
	{
		private var model : DemoModel = DemoModel.getInstance();  
		
		override public function execute(event:CairngormEvent):void {
		    super.execute(event);
			switch(event.type) {				
				case DemoEvent.EVENT_LOGIN:
					login(event as DemoEvent);
					break;	
				case DemoEvent.EVENT_SAVE:
					saveOrUpdate(event as DemoEvent);
					break;	
				case DemoEvent.EVENT_DOWNLOAD:
					downloadFile(event as DemoEvent);
					break;
				case DemoEvent.EVENT_UPLOAD:
					uploadFile(event as DemoEvent);
					break;						
				default:
					break;
			}
		}
		
		override protected function login_result(data:*):void {
			var ahthResult :User  = User(data);
			if(ahthResult.state != 1)
			{
				Alert.show("用户名和密码不正确！","提示");
			}
			else
			{
				model.currentState = 1;
			}
			notifyCaller();
		}
	
		override protected function saveOrUpdate_result(data:*):void {			
			notifyCaller();
		}
		
		override protected function downloadFile_result(data:*):void{			
			model.hashData = HashData(data);		
			notifyCaller();
		}
		
		override protected function uploadFile_result(data:*):void{
		
			notifyCaller();
		}
		
	}
}