package services
{
	import mx.collections.ArrayCollection;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import model.ClientVO;
	import model.CoinVO;
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
					remoteObject.addClient(client.firstName,
						client.lastName, client.address, client.city, client.state, 
						client.phone, client.accountBalance, client.pinCode).addResponder(this);
					break;
				}
					
					
				case Services.getLockedAccounts:	
				{					
					remoteObject.getLockedAccounts().addResponder(this);
					break;
				}	
					
				case Services.addSubFunds:	
				{					
					remoteObject.addSubClientFunds(params["clientId"], params["amount"]).addResponder(this);
					break;
				}	
					
				case Services.getcomissionRate:	
				{				
					remoteObject.getCommissionRate().addResponder(this);
					break;
				}
					
				case Services.addTransaction:	
				{				
					remoteObject.addTransaction(params['clientId'], params['amount'], params['coin'], params['numberShares'], params['pricePerShare'], params['commisionAmount'], params['brokerID']).addResponder(this);
					break;
				}
					
				case Services.getCoin:	
				{				
					remoteObject.getTodaysCoinRecords(params['symbol']).addResponder(this);
					break;
				}
					
				case Services.getCurrentHoldings:	
				{				
					remoteObject.getHoldingsByStock().addResponder(this);
					break;
				}
					
				case Services.getCurrentCashHoldings:	
				{				
					remoteObject.getCashHeld().addResponder(this);
					break;
				}
					
				case Services.sellStock:	
				{				
					remoteObject.buySellCoin(params['clientId'],  params['coinSymbol'], params['numberOfShares'], params['price']).addResponder(this);
					break;
				}	
					
				case Services.getTranactions:	
				{				
					remoteObject.getTranactions().addResponder(this);
					break;
				}
					
				case Services.changeCommissionRate:	
				{				
					remoteObject.changeCommissionRate(params).addResponder(this);
					new ServiceDelegate(Services.getcomissionRate, "comissionRate", null);
					break;
				}
					
				case Services.addUser:	
				{				
					remoteObject.addUser(params['screenName'], params['password']).addResponder(this);
					break;
				}
					
				case Services.updateClient:	
				{				
					remoteObject.updateClient(params['id'], 
						params['firstName'],
						params['lastName'],
						params['address'],
						params['city'],
						params['state'],
						params['phone'],
						params['pinCode']						
					).addResponder(this);
					new ServiceDelegate(Services.getClients, "clients", null);	
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
					
				case "selectedCoin":
				{
					var coin:CoinVO = new CoinVO();
					coin.symbol = params['symbol'];
					coin.name = params['name'];
					coin.priceHistory = new ArrayCollection((data as ResultEvent).result as Array);
					coin.price = coin.priceHistory.getItemAt(coin.priceHistory.length - 1)['price'];					
					modelLocator.selectedCoin = coin;
					break;
				}
					
				case "lockedAccounts":
				{
					collection = new ArrayCollection( );
					modelLocator.lockedAccounts = new ArrayCollection((data as ResultEvent).result as Array);
					break;
				}	
					
				case "comissionRate":
				{
					collection = new ArrayCollection((data as ResultEvent).result as Array);
					modelLocator.commissionRate = collection.getItemAt(0)['value'];
					break;
				}	
					
				case "currentHoldings":
				{
					modelLocator.currentHoldings = new ArrayCollection((data as ResultEvent).result as Array);
					break;
				}	
					
				case "cashOnHand":
				{
					modelLocator.cashOnHand = Number((data as ResultEvent).result);
					break;
				}
					
				case "transactions":
				{
					modelLocator.transactions = new ArrayCollection((data as ResultEvent).result as Array);
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