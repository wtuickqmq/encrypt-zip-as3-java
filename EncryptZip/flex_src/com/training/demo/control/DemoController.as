package com.training.demo.control
{
	import com.universalmind.cairngorm.control.FrontController;
	import com.training.demo.control.events.*;
	import com.training.demo.control.commands.*;
	
	public class DemoController extends FrontController 
	{
		public function DemoController()
		{
			super();			
			registerAllCommands();
		}
		
		private function registerAllCommands():void {
		 	addCommand(DemoEvent.EVENT_LOGIN,DemoCommand);
		 	addCommand(DemoEvent.EVENT_SAVE,DemoCommand);	
		 	addCommand(DemoEvent.EVENT_DOWNLOAD,DemoCommand);
		 	addCommand(DemoEvent.EVENT_UPLOAD,DemoCommand);	
		}

	}
}