package model
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class CoinVO
	{
		public var name:String;
		public var symbol:String;
		public var price:Number;
		public var priceHistory:ArrayCollection;
	}
}