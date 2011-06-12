package com.training.demo.model.vo
{
    import flash.utils.ByteArray;
   [RemoteClass(alias="com.training.demo.model.vo.HashData")]
   [Bindable]
	public class HashData
	{
		public function HashData()
		{
		}
		public var zipByte:ByteArray = new ByteArray();
		public var mdByte:ByteArray = new ByteArray();
		public var md:String = "";
		public var hashType:String ="";
		

	}
}




