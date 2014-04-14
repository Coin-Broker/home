package services
{
	import mx.binding.utils.ChangeWatcher;
	import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	import mx.events.PropertyChangeEvent;
	import mx.events.PropertyChangeEventKind;
	import mx.rpc.IResponder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import model.ClientVO;
	import model.ModelLocator;
	
	public class ServiceDelegate implements IResponder
	{
		public var modelLocator:ModelLocator = ModelLocator.getInstance();
		public var remoteObject:RemoteObject = modelLocator.remoteObject;
		
		private var modelProperty:String;
		private var service:String;
		private var params:Object;
		
		public function ServiceDelegate(service:String, modelProperty:String, params:Object = null)
		{
			this.modelProperty = modelProperty;
			this.service = service;
			this.params = params;
			
			//remoteObject. .addEventListener(ResultEvent.RESULT, handleResult);
			//remoteObject.addEventListener(FaultEvent.FAULT, handleFault);
			
			switch(service)
			{
				case Services.getClients:
				{
					remoteObject.requestClients().addResponder(this);
					break;
				}
					
				case Services.getCoins:
				{
					
					break;
				}
					
				case Services.getClient:
				{
					trace("getClient Called " + params)
					var client:ClientVO = new ClientVO();
					client.accountBalance = params['cashBalance'];
					client.city = params['city'];
					client.state = params['state'];
					client.firstName = params['firstName'];
					client.lastName = params['lastName'];
					client.pinCode = params['pin'];
					client.phone = params['phone'];
					client.address = params['address'];
					client.id = params['clientId'];
					modelLocator.selectedClient = client;
					break;
				}
					
				case Services.getClient:
				{
					
					break;
				}
					
				default:
				{
					break;
				}
			}
			
		}
		
		public function result(data:Object):void
		{
			trace(data);
			switch(modelProperty)
			{
				case "clients":
				{
					var collection:ArrayCollection;
					collection = new ArrayCollection( );
					modelLocator.clients = new ArrayCollection((data as ResultEvent).result as Array);
/*					collection = (modelLocator[modelProperty] as ArrayCollection);
					(modelLocator[modelProperty] as ArrayCollection).dispatchEvent(new PropertyChangeEvent ( PropertyChangeEventKind.UPDATE));
					collection.refresh();*/
					break;
				}
					
				default:
				{
					break;
				}
			}
			
			
			
		}
		
		public function fault(info:Object):void
		{
		}
	}
}