package com.training.demo.model {	
	
	import com.adobe.cairngorm.model.IModelLocator;
	import com.training.demo.model.vo.HashData;
	
	import flash.utils.ByteArray;
	
	
  	[Bindable]
  	public class DemoModel implements IModelLocator {	
		//当前用户所在系统模块
		public var currentState:Number= 1;		
        public var downByteArrary:ByteArray =new ByteArray();
        public var upByteArrary:ByteArray =new ByteArray();
        public var hashData:HashData = new HashData();
	    // **********************************************************
	    // 单例模式
	    // **********************************************************
	    public static function getInstance() : com.training.demo.model.DemoModel {
			if ( modelLocator == null ) {
				modelLocator = new com.training.demo.model.DemoModel(new ConstructorBlock);				
			}
			return modelLocator;
		}
     	/**
     	 * 默认构造方法
     	 * @param block 需要是一个私有类，防止使用公共方法直接实例化多个实例。
     	 */
		public function DemoModel(block:ConstructorBlock) {
			if ( com.training.demo.model.DemoModel.modelLocator != null ) {
				throw new Error( "只能实例化一个实例！" );   
			} 
			com.training.demo.model.DemoModel.modelLocator = this;			
		}
		
		// **********************************************************
	    // 单例模式属性
	    // **********************************************************
	    private static var modelLocator : com.training.demo.model.DemoModel = null;
	}
}
//声明一个外部包，防止直接构造 ModelLocator 实例是阻塞
class ConstructorBlock {  }





