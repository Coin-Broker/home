package model
{
	[Bindable]
	public class UserVO
	{
		public var screenName:String;
		public var password:String;
		public var lastAttempt:String;
		public var attemptCount:Number;
		public var locked:Boolean;
		public var id:int;
	}
}