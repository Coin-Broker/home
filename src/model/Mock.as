package model
{
	public class Mock
	{
		public function Mock()
		{
		}
		
		public static function getCoinVO():CoinVO
		{
			var coin:CoinVO = new CoinVO();
			coin.name = "BitCoin";
			coin.symbol = "BigBC";
			coin.price = 222.33; 
			return coin;
		}
		
		public static function getClientVO():ClientVO
		{
			var client:ClientVO = new ClientVO();
			client.address = "123 Any Street" ;
			client.city = "SomeTown" ;
			client.firstName = "Boo" ;
			client.lastName = "BooWHO" ;
			client.pinCode = "526F" ;
			client.state = "FL" ;
			
			return client;
		}
	}
}