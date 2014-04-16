
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.Date;


public class Getcoin{

	//Variables
	public static String btc_price;
	public static String ltc_price;
	public static Date now = new Date();
	public static String currentTime;
	

	public static void main(String[] args) throws IOException, ParseException  {

		
		
                //convert date for mysql
                SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                currentTime = sdf.format(now);
                //System.out.println(ticker + " " + currentTime);

	        try {
        	        Class.forName("com.mysql.jdbc.Driver");
        	} 
		catch (ClassNotFoundException e) {
                	e.printStackTrace();
                	return;
        	}

        	Connection connection = null;

        	try {
                	connection = DriverManager
                		.getConnection("jdbc:mysql://localhost:3306/bitcoin","java_user", "javapass");


	                Statement st = (Statement) connection.createStatement();
        	        st.executeUpdate("INSERT INTO daily_coin(date)" + "VALUES (\"" + currentTime + "\")");
                	connection.close();

	        } 
		catch (SQLException e) {
                	e.printStackTrace();
	                return;
        	}






		//BTC and LTC API
		String URL_BTC = "https://coinbase.com/api/v1/currencies/exchange_rates";
		String URL_LTC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=3";

		//Require BTC to Coin API
		String URL_FortyTwo = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=141";
		String URL_ANC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=66";
		String URL_ARG = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=48";
		String URL_BC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=179";
		String URL_BCX = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=142";
		String URL_BEN = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=157";
		String URL_BET = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=129";
		String URL_BQC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=10";
		String URL_BTB = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=23";
		String URL_BTE = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=49";
		String URL_BTG = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=50";
		String URL_CACH = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=154";
		String URL_CASH = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=150";
		String URL_CAT = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=136";
		String URL_CGB = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=70";
		String URL_CLR = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=95";
		String URL_CRC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=58";
		String URL_CSC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=68";
		String URL_DEM = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=131";
		String URL_DGB = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=167";
		String URL_DGC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=26";
		String URL_DMD = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=72";
		String URL_DOGE = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=132";
		String URL_DRK = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=155";
		String URL_DVC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=40";
		String URL_EAC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=139";
		String URL_ELC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=12";
		String URL_EMC2 = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=188";
		String URL_EXE = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=183";
		String URL_FLAP = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=165";
		String URL_FRC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=39";
		String URL_FRK = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=33";
		String URL_FST = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=44";
		String URL_FTC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=5";
		String URL_GLC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=76";
		String URL_GLD = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=30";
		String URL_HBN = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=80";
		String URL_HVC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=185";
		String URL_IFC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=59";
		String URL_IXC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=38";
		String URL_JKC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=25";
		String URL_KDC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=178";
		String URL_LEAF = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=148";
		String URL_LKY = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=34";
		String URL_LOT = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=137";
		String URL_MAX = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=152";
		String URL_MEC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=45";
		String URL_MEOW = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=149";
		String URL_MINT = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=156";
		String URL_MNC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=7";
		String URL_MRY = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=189";
		String URL_MZC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=164";
		String URL_NET = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=134";
		String URL_NMC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=29";
		String URL_NRB = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=54";
		String URL_NVC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=13";
		String URL_NXT = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=159";
		String URL_NYAN = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=184";
		String URL_OSC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=144";
		String URL_PHS = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=86";
		String URL_POT = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=173";
		String URL_PPC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=28";
		String URL_PTS = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=119";
		String URL_PXC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=31";
		String URL_QRK = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=71";
		String URL_RDD = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=169";
		String URL_RPC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=143";
		String URL_SAT = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=168";
		String URL_SBC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=51";
		String URL_SMC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=158";
		String URL_SPA = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=180";
		String URL_SRC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=88";
		String URL_SXC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=153";
		String URL_TAG = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=117";
		String URL_TAK = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=166";
		String URL_TRC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=27";
		String URL_UNO = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=133";
		String URL_UTC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=163";
		String URL_VTC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=151";
		String URL_WDC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=14";
		String URL_XJO = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=115";
		String URL_YAC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=11";
		String URL_YBC = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=73";
		String URL_ZED = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=170";
		String URL_ZET = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=85";

		//Require LTC to coin API
		String URL_AUR = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=161";
		String URL_BAT = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=186";
		String URL_COL = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=109";
		String URL_CTM = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=175";
		String URL_FLO = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=61";
		String URL_MOON = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=145";
		String URL_RED = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=87";
		String URL_TIPS = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=147";
		String URL_TIX = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=107";
		String URL_ZEIT = "http://pubapi.cryptsy.com/api.php?method=singlemarketdata&marketid=176";

		
		//Get BTC Price
		btc_price = get_btc(URL_BTC);
		//System.out.println("BTC Price: " + btc_price);
		
		
		//Get LTC Price
		ltc_price = get_ltc(URL_LTC);
		//System.out.println("LTC Price: " + ltc_price);
		
		//Get Other coins that require BTC conversion
		btc_coins(URL_FortyTwo, "42"); 
		btc_coins(URL_ANC, "ANC"); 
		btc_coins(URL_ARG, "ARG"); 
		btc_coins(URL_BC, "BC"); 
		btc_coins(URL_BCX, "BCX"); 
		btc_coins(URL_BEN, "BEN"); 
		btc_coins(URL_BET, "BET"); 
		btc_coins(URL_BQC, "BQC"); 
		btc_coins(URL_BTB, "BTB"); 
		btc_coins(URL_BTE, "BTE"); 
		btc_coins(URL_BTG, "BTG"); 
		btc_coins(URL_CACH, "CACH"); 
		btc_coins(URL_CASH, "CASH"); 
		btc_coins(URL_CAT, "CAT"); 
		btc_coins(URL_CGB, "CGB"); 
		btc_coins(URL_CLR, "CLR"); 
		btc_coins(URL_CRC, "CRC"); 
		btc_coins(URL_CSC, "CSC"); 
		btc_coins(URL_DEM, "DEM"); 
		btc_coins(URL_DGB, "DGB"); 
		btc_coins(URL_DGC, "DGC");
		btc_coins(URL_DMD, "DMD");
		btc_coins(URL_DOGE, "DOGE");
		btc_coins(URL_DRK, "DRK");
		btc_coins(URL_DVC, "DVC");
		btc_coins(URL_EAC, "EAC");
		btc_coins(URL_ELC, "ELC");
		btc_coins(URL_EMC2, "EMC2");
		btc_coins(URL_EXE, "EXE");
		btc_coins(URL_FLAP, "FLAP");
		btc_coins(URL_FRC, "FRC");
		btc_coins(URL_FRK, "FRK");
		btc_coins(URL_FST, "FST");
		btc_coins(URL_FTC, "FTC");
		btc_coins(URL_GLC, "GLC");
		btc_coins(URL_GLD, "GLD");
		btc_coins(URL_HBN, "HBN");
		btc_coins(URL_HVC, "HVC");
		btc_coins(URL_IFC, "IFC");
		btc_coins(URL_IXC, "IXC");
		btc_coins(URL_JKC, "JKC");
		btc_coins(URL_KDC, "KDC");
		btc_coins(URL_LEAF, "LEAF");
		btc_coins(URL_LKY, "LKY");
		btc_coins(URL_LOT, "LOT");
		btc_coins(URL_MAX, "MAX");
		btc_coins(URL_MEC, "MEC");
		btc_coins(URL_MEOW, "MEOW");
		btc_coins(URL_MINT, "MINT");
		btc_coins(URL_MNC, "MNC");
		btc_coins(URL_MRY, "MRY");
		btc_coins(URL_MZC, "MZC");
		btc_coins(URL_NET, "NET");
		btc_coins(URL_NMC, "NMC");
		btc_coins(URL_NRB, "NRB");
		btc_coins(URL_NVC, "NVC");
		btc_coins(URL_NXT, "NXT");
		btc_coins(URL_NYAN, "NYAN");
		btc_coins(URL_OSC, "OSC");
		btc_coins(URL_PHS, "PHS");
		btc_coins(URL_POT, "POT");
		btc_coins(URL_PPC, "PPC");
		btc_coins(URL_PTS, "PTS");
		btc_coins(URL_PXC, "PXC");
		btc_coins(URL_QRK, "QRK");
		btc_coins(URL_RDD, "RDD");
		btc_coins(URL_RPC, "RPC");
		btc_coins(URL_SAT, "SAT");
		btc_coins(URL_SBC, "SBC");
		btc_coins(URL_SMC, "SMC");
		btc_coins(URL_SPA, "SPA");
		btc_coins(URL_SRC, "SRC");
		btc_coins(URL_SXC, "SXC");
		btc_coins(URL_TAG, "TAG");
		btc_coins(URL_TAK, "TAK");
		btc_coins(URL_TRC, "TRC");
		btc_coins(URL_UNO, "UNO");
		btc_coins(URL_UTC, "UTC");
		btc_coins(URL_VTC, "VTC");
		btc_coins(URL_WDC, "WDC");
		btc_coins(URL_XJO, "XJO");
		btc_coins(URL_YAC, "YAC");
		btc_coins(URL_YBC, "YBC");
		btc_coins(URL_ZED, "ZED");
		btc_coins(URL_ZET, "ZET");
		
		
		//Get Other coins that require LTC conversion
		ltc_coins(URL_AUR, "AUR");
		ltc_coins(URL_BAT, "BAT");
		ltc_coins(URL_COL, "COL");
		ltc_coins(URL_CTM, "CTM");
		ltc_coins(URL_FLO, "FLO");
		ltc_coins(URL_MOON, "MOON");
		ltc_coins(URL_RED, "RED");
		ltc_coins(URL_TIPS, "TIPS");
		ltc_coins(URL_TIX, "TIX");
		ltc_coins(URL_ZEIT, "ZEIT");
	
		
		
	}
	
	public static String get_btc(String url) throws IOException{
		
		String btc_price = null;
		
		//Hit api
		StringBuilder btc_data = get_data(url);
		//System.out.println(btc_data);
		
		//Get price
		String re1="(\"btc_to_usd\")";	// Double Quote String 1
	    String re2="(:)";	// Any Single Character 1
	    String re3="(\")";	// Any Single Character 2
	    String re4="([+-]?\\d*\\.\\d+)(?![-+0-9\\.])";	// Float 1
	    String re5="(\")";	// Any Single Character 3

	    Pattern p = Pattern.compile(re1+re2+re3+re4+re5,Pattern.CASE_INSENSITIVE | Pattern.DOTALL);
	    Matcher m = p.matcher(btc_data);
	    if (m.find())
	    {
	        String float1=m.group(4);
	        btc_price = float1.toString();
	        //System.out.print(btc_price);
	    }
		
		//Put in database
	    db_insert("BTC", btc_price);
		
	    //return btc_price
	    return btc_price;
	}
	
	public static String get_ltc(String url) throws IOException{
		
		String ltc_price = null;
		
		//Hit api
		StringBuilder ltc_data = get_data(url);
		//System.out.println(ltc_data);
		
		//Get price
	    String re1="(\"lasttradeprice\")";	// Double Quote String 1
	    String re2="(:)";	// Any Single Character 1
	    String re3="(\")";	// Any Single Character 2
	    String re4="([+-]?\\d*\\.\\d+)(?![-+0-9\\.])";	// Float 1
	    String re5="(\")";	// Any Single Character 3

	    Pattern p = Pattern.compile(re1+re2+re3+re4+re5,Pattern.CASE_INSENSITIVE | Pattern.DOTALL);
	    Matcher m = p.matcher(ltc_data);
	    if (m.find())
	    {
	        String float1=m.group(4);
	        ltc_price = float1.toString();
	        //System.out.print(ltc_price);
	    }
		
		//Convert BTC to USD
	    float ltc_usd =  Float.parseFloat(ltc_price) * Float.parseFloat(btc_price);
	    ltc_price = Float.toString(ltc_usd);
	    
	    
		//Put in database
	    db_insert("LTC", ltc_price);
	    
		return ltc_price;
	}
	
	public static void btc_coins(String url, String coin) throws IOException{
		String coin_price = null;
		
		//Hit api
		StringBuilder coin_data = get_data(url);
		//System.out.println(ltc_data);
		
		//Get price
	    String re1="(\"lasttradeprice\")";	// Double Quote String 1
	    String re2="(:)";	// Any Single Character 1
	    String re3="(\")";	// Any Single Character 2
	    String re4="([+-]?\\d*\\.\\d+)(?![-+0-9\\.])";	// Float 1
	    String re5="(\")";	// Any Single Character 3

	    Pattern p = Pattern.compile(re1+re2+re3+re4+re5,Pattern.CASE_INSENSITIVE | Pattern.DOTALL);
	    Matcher m = p.matcher(coin_data);
	    if (m.find())
	    {
	        String float1=m.group(4);
	        coin_price = float1.toString();
	        //System.out.print(coin_price);
	    }
		//Convert BTC to USD
	    float coin_usd =  Float.parseFloat(coin_price) * Float.parseFloat(btc_price);
	    coin_price = Float.toString(coin_usd);
	    //System.out.println(coin + " Price: " + coin_usd);
	    
		//Put in database 
	    db_insert(coin, coin_price);
	}
	
	public static void ltc_coins(String url, String coin) throws IOException{
		String coin_price = null;
		
		//Hit api
		StringBuilder coin_data = get_data(url);
		//System.out.println(ltc_data);
		
		//Get price
	    String re1="(\"lasttradeprice\")";	// Double Quote String 1
	    String re2="(:)";	// Any Single Character 1
	    String re3="(\")";	// Any Single Character 2
	    String re4="([+-]?\\d*\\.\\d+)(?![-+0-9\\.])";	// Float 1
	    String re5="(\")";	// Any Single Character 3

	    Pattern p = Pattern.compile(re1+re2+re3+re4+re5,Pattern.CASE_INSENSITIVE | Pattern.DOTALL);
	    Matcher m = p.matcher(coin_data);
	    if (m.find())
	    {
	        String float1=m.group(4);
	        coin_price = float1.toString();
	        //System.out.print(coin_price);
	    }
		//Convert LTC to USD
	    float coin_usd =  Float.parseFloat(coin_price) * Float.parseFloat(ltc_price);
	    coin_price = Float.toString(coin_usd);
	    //System.out.println(coin + " Price: " + coin_usd);
	    
		//Put in database 
	    db_insert(coin, coin_price);
	}
	
	
	public static StringBuilder get_data(String url) throws IOException{
		java.net.URL endpointUrl = new java.net.URL(url);
		java.net.HttpURLConnection request = (java.net.HttpURLConnection)endpointUrl.openConnection();
		request.setRequestMethod("GET");
		request.connect();
		 
		java.io.BufferedReader rd  = new java.io.BufferedReader(new java.io.InputStreamReader(request.getInputStream()));
		StringBuilder response = new StringBuilder();
		String line = null;
		while ((line = rd.readLine()) != null){
			response.append(line + '\n');
			}
		request.disconnect();
		rd.close();
		//System.out.println(response);
		return response;
	
	}//end Get_data
	
	public static void db_insert (String ticker, String price) throws IOException{
		
	/*	
	//convert date for mysql
	SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	String currentTime = sdf.format(now);
	//System.out.println(ticker + " " + currentTime);
	*/

        try {
                Class.forName("com.mysql.jdbc.Driver");
        } catch (ClassNotFoundException e) {
                e.printStackTrace();
                return;
        }
        
        Connection connection = null;

        try {
                connection = DriverManager
                .getConnection("jdbc:mysql://localhost:3306/bitcoin","java_user", "javapass");


	        Statement st = (Statement) connection.createStatement();
     		st.executeUpdate("update daily_coin set `" + ticker + "` = " + price + " where date= \"" + currentTime + "\"");


		//st.executeUpdate("INSERT INTO daily_coin( " + ticker + " )" + "VALUES (\"" + price + "\") where date= \"" + currentTime + "\"");



        	connection.close();

        } catch (SQLException e) {
                e.printStackTrace();
                return;
        }
	
	
	}
	
	
}//end getcoin.java





