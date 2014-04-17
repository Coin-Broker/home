package services
{
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
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
					remoteObject.requestCoins().addResponder(this);
					break;
				}
					
				case Services.getClient:
				{					
					remoteObject.requestClientCoins(int(params['clientId'])).addResponder(this);
					
					break;
				}
					
				case Services.addClient:
				{
					var client:ClientVO = params as ClientVO;
					/*remoteObject.addClient(client).addResponder(this);*/
					
					
					remoteObject.addClient(client.firstName,
						client.lastName, client.address, client.city, client.state, 
						client.phone, client.accountBalance, client.pinCode).addResponder(this);
					
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
			var collection:ArrayCollection;
			switch(modelProperty)
			{
				case "clients":
				{
					collection = new ArrayCollection( );
					modelLocator.clients = new ArrayCollection((data as ResultEvent).result as Array);
/*					collection = (modelLocator[modelProperty] as ArrayCollection);
					(modelLocator[modelProperty] as ArrayCollection).dispatchEvent(new PropertyChangeEvent ( PropertyChangeEventKind.UPDATE));
					collection.refresh();*/
					break;
				}
					
				case "coins":
				{
					collection = new ArrayCollection( );
					modelLocator.coins = new ArrayCollection((data as ResultEvent).result as Array);
					break;
				}
					
				case "selectedClient":
				{
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
					
					collection = new ArrayCollection( );
					client.coins = new ArrayCollection((data as ResultEvent).result as Array);
					
					modelLocator.selectedClient = client;
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
			trace(info);
		}
	}
}