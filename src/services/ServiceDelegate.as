package services
{
	import mx.collections.ArrayCollection;
	import mx.controls.Alert;
	import mx.rpc.IResponder;
	import mx.rpc.events.ResultEvent;
	import mx.rpc.remoting.RemoteObject;
	
	import model.ClientVO;
	import model.CoinVO;
	import model.ModelLocator;
	import model.UserVO;
	
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
					new ServiceDelegate(Services.getClients, "clients", null);
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
					new ServiceDelegate(Services.getCurrentCashHoldings, "cashOnHand", null);
					remoteObject.addTransaction(params['clientId'],  "BALANCE", params["amount"], 1, 0, modelLocator.currentUser.id).addResponder(this);
					

					break;
				}	
					
				case Services.getcomissionRate:	
				{				
					remoteObject.getCommissionRate().addResponder(this);
					break;
				}
					
				case Services.addTransaction:	
				{				
					remoteObject.addTransaction(params['clientId'],  params['coin'], params['numberShares'], params['pricePerShare'], params['commisionAmount'], params['brokerID']).addResponder(this);
					new ServiceDelegate(Services.getTranactions, "transactions", null);
					break;
				}
					
				case Services.getCoin:	
				{				
					//remoteObject.getTodaysCoinRecords(params['symbol']).addResponder(this);
					remoteObject.getCoinHistory(params['symbol']).addResponder(this);
					break;
				}
					
				case Services.getCoinHistory:	
				{				
					remoteObject.getCoinHistory(params['symbol']).addResponder(this);
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
					remoteObject.buySellCoin(params['clientId'],  params['coinSymbol'], params['numberOfShares'], params['price'], params['commissionRate'], params['brokerID']).addResponder(this);
					remoteObject.addTransaction(params['clientId'],  params['coinSymbol'], params['numberOfShares'], params['price'], params['commissionRate'] * params['numberOfShares'] * params['price'], params['brokerID']).addResponder(this);
					new ServiceDelegate(Services.getCurrentHoldings, "currentHoldings", null);
					new ServiceDelegate(Services.getCurrentCashHoldings, "cashOnHand", null);
					new ServiceDelegate(Services.getTranactions, "transactions", null);
					new ServiceDelegate(Services.getUsers, "users", null);
					//new ServiceDelegate(Services.getClient, "selectedClient", params);
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
				case Services.getUsers:	
				{				
					remoteObject.getUsers().addResponder(this);
					break;
				}
					
				case Services.addUser:	
				{				
					remoteObject.addUser(params['screenName'], params['password']).addResponder(this);
					new ServiceDelegate(Services.getUsers, "users", null);
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
					
				case Services.login:	
				{				
					remoteObject.login(params['screenName'], params['password']).addResponder(this);
					break;
				}
					
				case Services.getMetrics:	
				{				
					remoteObject.getMetrics().addResponder(this);
					break;
				}
					
				case Services.getSaleActivity:	
				{				
					//DATE WEEK MONTH
					//"1 MONTH" "12 WEEKS" "1 YEAR"
					remoteObject.getSaleActivity(params['range'], params['back']).addResponder(this);
					break;
				}
					
				case Services.updatePassword:	
				{
					remoteObject.updateUserPassword(params['userId'], params['password']).addResponder(this);
					break;
				}
					
					
				case Services.unlockAccount:	
				{
					remoteObject.unlockAccount(params['screenName']).addResponder(this);
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
			trace(data.result);
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
					
				case "users":
				{
					modelLocator.users = new ArrayCollection((data as ResultEvent).result as Array);
					break;
				}
					
				case "currentUser":
				{
					if((data as ResultEvent).result is String){
						switch((data as ResultEvent).result)
						{
							case "Failure1":
							{
								Alert.show("Account locked due to many failed login attempts");
								break;
							}
								
							case "Failure2":
							{
								Alert.show("Account is now locked due to many failed login attempts");
								break;
							}
								
							default:
							{
								Alert.show("Incorrect credentials");
								break;
							}
						}

						
						return;
					}
						
					
					var obj:* = (data as ResultEvent).result;
					var user:UserVO = new UserVO();
					user.id = obj["id"];
					user.manager = obj["manager"] == "";
					user.screenName = obj["screenName"];
					modelLocator.currentUser = user;
					break;
				}
					
				case "brokerageMetrics":
				{					
					modelLocator.brokerageMetrics = (data as ResultEvent).result[0];
					break;
				}
					
				case "dailyActive":
				{					
					modelLocator.dailyActive = new ArrayCollection((data as ResultEvent).result as Array);
					break;
				}
					
				case "weeklyActive":
				{					
					modelLocator.weeklyActive = new ArrayCollection((data as ResultEvent).result as Array);
					break;
				}
					
				case "monthlyActive":
				{					
					modelLocator.monthlyActive = new ArrayCollection((data as ResultEvent).result as Array);
					break;
				}
					
				case "unlockedAccounts":
				{					
					modelLocator.update();
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