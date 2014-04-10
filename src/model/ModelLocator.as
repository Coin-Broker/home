package model
{
	import mx.collections.ArrayCollection;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;

	[Bindable]
	public class ModelLocator 
	{
		
		private var remoteObject:RemoteObject;
		public var clients:ArrayCollection;
		public var coins:ArrayCollection
		
		public var selectedClient:ClientVO = Mock.getClientVO();
		public var selectedCoin:CoinVO = Mock.getCoinVO();	
		
		
		public function updateClientList():void
		{
			remoteObject.requestClients();
		}
		
		protected function handleResult(event:ResultEvent):void
		{
			trace(event.result);
			
		}
		
		protected function handleFault(event:FaultEvent):void
		{
			trace(event);
			
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
			this.remoteObject = new RemoteObject();
			remoteObject.destination = "MySqlRequest";
			remoteObject.endpoint = " http://139.62.63.205/~n00648466/Amfphp/";
			remoteObject.source = "MySqlServices";
			remoteObject.addEventListener(ResultEvent.RESULT, handleResult);
			remoteObject.addEventListener(FaultEvent.FAULT, handleFault);
			
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