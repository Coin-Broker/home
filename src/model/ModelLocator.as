package model
{
	import mx.collections.ArrayCollection;
	import mx.rpc.remoting.RemoteObject;
	
	import services.ServiceDelegate;
	import services.Services;

	[Bindable]
	public class ModelLocator 
	{
		public var currentUser:UserVO = null;
		
		public var remoteObject:RemoteObject;
		public var clients:ArrayCollection;
		public var coins:ArrayCollection;
		
		public var selectedClient:ClientVO;
		public var selectedCoin:CoinVO ;
		
		public var lockedAccounts:ArrayCollection = new ArrayCollection();
		public var users:ArrayCollection = new ArrayCollection();
		
		public var currentHoldings:ArrayCollection = new ArrayCollection();
		public var transactions:ArrayCollection = new ArrayCollection();
		public var dailyActive:ArrayCollection = new ArrayCollection();
		public var weeklyActive:ArrayCollection = new ArrayCollection();
		public var monthlyActive:ArrayCollection = new ArrayCollection();
		
		public var commissionRate:Number;
		
		public var currentView:int;
		
		public var cashOnHand:Number;
		
		public var brokerageMetrics:Object;
		
		
		private static var instance:ModelLocator;
		public var random:Number;
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
			remoteObject.endpoint = "http://50.159.170.159/Amfphp/";
			//remoteObject.endpoint = "Amfphp/";

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
		
		
		
		public function update():void
		{
			new ServiceDelegate(Services.getClients, "clients", null);	
			new ServiceDelegate(Services.getCoins, "coins", null);				
			new ServiceDelegate(Services.getcomissionRate, "comissionRate", null);
			new ServiceDelegate(Services.getCurrentHoldings, "currentHoldings", null);
			new ServiceDelegate(Services.getCurrentCashHoldings, "cashOnHand", null);
			new ServiceDelegate(Services.getTranactions, "transactions", null);
			new ServiceDelegate(Services.getUsers, "users", null);
			new ServiceDelegate(Services.getLockedAccounts, "lockedAccounts", null);
			new ServiceDelegate(Services.getMetrics, "brokerageMetrics", null);
			new ServiceDelegate(Services.getSaleActivity, "dailyActive", {range:"DATE", back:"1 MONTH"});
			new ServiceDelegate(Services.getSaleActivity, "weeklyActive", {range:"WEEK", back:"12 WEEK"});
			new ServiceDelegate(Services.getSaleActivity, "monthlyActive", {range:"MONTH", back:"1 YEAR"});
			random = Number( int(Math.random() * 8999)  + 1000);
		}
	}
}

/**
 * Inner class which restricts constructor access to Private
 */
class Private {}