package model
{
	import mx.collections.ArrayCollection;

	[Bindable]
	public class ModelLocator
	{
		public var clientList:ArrayCollection;
		public var stockList:ArrayCollection
		
		public var selectedClient:Client;
		
		
		
		
		
		
		
		
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