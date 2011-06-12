package com.training.demo.model.vo
{
	[RemoteClass(alias="com.training.demo.model.vo.User")]
	[Bindable]
	public class User
	{
		public function User()
		{
		}
		public var userName:String;//用户名
		public var password:String;//用户密码
		public var state:int;      //用户状态
		public var id:int;      //用户ID

	}
}