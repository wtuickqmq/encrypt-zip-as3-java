package com.training.demo.control.delegates
{
		
	import com.training.commons.base.BaseDelegate;
	import mx.rpc.IResponder;	
	
	public class DemoDelegate extends BaseDelegate
	{
		public function DemoDelegate(responder:IResponder = null)
		{
			super(responder,"demoService");
		}
	}
}