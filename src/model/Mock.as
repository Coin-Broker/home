package model
{
	import mx.collections.ArrayCollection;

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
		
		public static function getClients():ArrayCollection
		{
			var arrList:ArrayCollection = new ArrayCollection();
			var client:ClientVO ;
			client = new ClientVO();
			client.address = "123 Any Street" ;
			client.city = "SomeTown" ;
			client.firstName = "Boo" ;
			client.lastName = "BooWHO" ;
			client.pinCode = "526F" ;
			client.state = "FL" ;
			arrList.addItem(client);
			
			client = new ClientVO();
			client.address = "123 Any Street" ;
			client.city = "SomeTown" ;
			client.firstName = "Boo" ;
			client.lastName = "BooWHO" ;
			client.pinCode = "526F" ;
			client.state = "FL" ;
			arrList.addItem(client);
			
			client = new ClientVO();
			client.address = "123 Any Street" ;
			client.city = "SomeTown" ;
			client.firstName = "Boo" ;
			client.lastName = "BooWHO" ;
			client.pinCode = "526F" ;
			client.state = "FL" ;
			arrList.addItem(client);
			
			client = new ClientVO();
			client.address = "123 Any Street" ;
			client.city = "SomeTown" ;
			client.firstName = "Boo" ;
			client.lastName = "BooWHO" ;
			client.pinCode = "526F" ;
			client.state = "FL" ;
			arrList.addItem(client);
			
			
			return arrList;
		}
		
		public static function getCoins():ArrayCollection
		{
			var arrList:ArrayCollection = new ArrayCollection();
			var coin:CoinVO ;
			coin = new CoinVO();
			coin.name = "Bit1" ;
			coin.price = 22.13 ;
			coin.symbol = "B1" ;
			arrList.addItem(coin);
			
			
			coin = new CoinVO();
			coin.name = "Bit2" ;
			coin.price = 22.14 ;
			coin.symbol = "B2" ;
			arrList.addItem(coin);
			
			coin = new CoinVO();
			coin.name = "Bit3" ;
			coin.price = 22.15 ;
			coin.symbol = "B3" ;
			arrList.addItem(coin);
			
			coin = new CoinVO();
			coin.name = "Bit4" ;
			coin.price = 22.16 ;
			coin.symbol = "B3" ;
			arrList.addItem(coin);
			
			
			return arrList;
		}
	}
}