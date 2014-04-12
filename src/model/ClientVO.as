package model
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class ClientVO
	{
		public var firstName:String;
		public var lastName:String;
		public var address:String;
		public var city:String;
		public var state:String;
		public var pinCode:String;
		public var phone:String;
		public var accountBalance:Number;
		
		public var coins:ArrayCollection;
	}
}