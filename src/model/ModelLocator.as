package model
{
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	[Bindable]
	public class ModelLocator 
	{
		
		public var remoteObject:RemoteObject;
		public var clients:ArrayCollection = Mock.getClients();
		public var coins:ArrayCollection = Mock.getCoins();
		
		public var selectedClient:ClientVO;
		public var selectedCoin:CoinVO = Mock.getCoinVO();	
		
		public static function getClient():void
		{
			// TODO Auto Generated method stub
			
		}
		
		private static var instance:ModelLocator;
		/**
		 *
		 * Defines the Singleton instance of the Application 
		 * <code>ModelLocator</code>
		 *
		 * @param inner class instance which restricts constructor access
		 *
		 */
		public function ModelLocator(access:Private)
		{
			if ( access == null )
			{
				//throw ERROR;
			}
			instance = this;
			/*this.remoteObject = new RemoteObject();
			remoteObject.destination = "MySqlRequest";
			remoteObject.endpoint = " http://139.62.63.205/~n00648466/Amfphp/";
			remoteObject.source = "MySqlServices";	*/	
			
			this.remoteObject = new RemoteObject();
			remoteObject.destination = "MySqlRequest";
			//remoteObject.endpoint = "http://www.coin-broker.info/Amfphp/";
			remoteObject.endpoint = "Amfphp/";
			remoteObject.source = "MySqlServices";	
		}
		
		
		
		/**
		 *
		 * Retrieves the Singleton instance of the <code>ModelLocator</code>
		 *
		 * @return singleton instance of <code>ModelLocator</code>
		 *
		 */
		public static function getInstance() : ModelLocator
		{
			if ( instance == null )
			{
				instance = new ModelLocator( new Private() );
			}
			return instance;
		}
		
		
		
	}
}

/**
 * Inner class which restricts constructor access to Private
 */
class Private {}