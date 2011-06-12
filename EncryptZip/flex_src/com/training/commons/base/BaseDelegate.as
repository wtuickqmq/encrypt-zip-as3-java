package  com.training.commons.base
{
	import com.universalmind.cairngorm.business.Delegate;
	import com.universalmind.cairngorm.events.Callbacks;	
	import mx.collections.ArrayCollection;
	import mx.controls.*;
	import mx.rpc.AsyncToken;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	public class BaseDelegate extends Delegate
	{
				
		public function BaseDelegate(responder:IResponder = null,serviceID:String=null)
		{	
			super(responder,serviceID);
		}       
       
       				
		public function login(o:Object):void
		{	
			var intercept:Callbacks   = new Callbacks(login_Result,fault);
	        var token	 :AsyncToken = service.login(o);
	        prepareHandlers(token,intercept); 
		}

		public function login_Result(event:ResultEvent):void
		{				
            notifyCaller(event.result);
		}
		
		
		public function saveOrUpdate(o:Object):void
		{	
			var intercept:Callbacks   = new Callbacks(saveOrUpdate_result,fault);
	        var token	 :AsyncToken = service.saveOrUpdate(o);
	        prepareHandlers(token,intercept); 
		}

		public function saveOrUpdate_result(event:ResultEvent):void
		{				
            notifyCaller(event.result);
		}
    	
		public function downloadFile(o:Object):void
		{	
			var intercept:Callbacks   = new Callbacks(downloadFile_result,fault);
	        var token	 :AsyncToken = service.downloadFile(o);
	        prepareHandlers(token,intercept); 
		}

		public function downloadFile_result(event:ResultEvent):void
		{				
            notifyCaller(event.result);
		}
		
		public function uploadFile(o:Object):void
		{	
			var intercept:Callbacks   = new Callbacks(uploadFile_result,fault);
	        var token	 :AsyncToken = service.uploadFile(o);
	        prepareHandlers(token,intercept); 
		}

		public function uploadFile_result(event:ResultEvent):void
		{				
            notifyCaller();
		}
		
		//handle err
	    public function fault(event:*=null):void {
	          Alert.show(event.message);
	     
		}
	}
}