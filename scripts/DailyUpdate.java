import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;



public class DailyUpdate {

	public static Calendar now = Calendar.getInstance();
	public static String yesterday;
	public static Date today = new Date();
	public static String currentTime;

	
	public static void main(String[] args) throws IOException {
		// TODO Auto-generated method stub
		
        SimpleDateFormat sdf = new java.text.SimpleDateFormat("yyyy-MM-dd");
        currentTime = sdf.format(today);
		
        //convert date for mysql
        DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
        Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -1);    
        yesterday = dateFormat.format(cal.getTime());
       
        //Create DB row
        
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
		        st.executeUpdate("INSERT INTO `history_table`(`date`) VALUES (\"" + yesterday + "\")");
	        	connection.close();
	        	
	    } 
		catch (SQLException e) {
	        e.printStackTrace();
            return;
		}
        
		db_insert(yesterday, "42"); 
		db_insert(yesterday, "ANC"); 
		db_insert(yesterday, "ARG"); 
		db_insert(yesterday, "BC"); 
		db_insert(yesterday, "BCX"); 
		db_insert(yesterday, "BEN"); 
		db_insert(yesterday, "BET"); 
		db_insert(yesterday, "BQC"); 
		db_insert(yesterday, "BTB"); 
		db_insert(yesterday, "BTE"); 
		db_insert(yesterday, "BTG"); 
		db_insert(yesterday, "CACH"); 
		db_insert(yesterday, "CASH"); 
		db_insert(yesterday, "CAT"); 
		db_insert(yesterday, "CGB"); 
		db_insert(yesterday, "CLR"); 
		db_insert(yesterday, "CRC"); 
		db_insert(yesterday, "CSC"); 
		db_insert(yesterday, "DEM"); 
		db_insert(yesterday, "DGB"); 
		db_insert(yesterday, "DGC");
		db_insert(yesterday, "DMD");
		db_insert(yesterday, "DOGE");
		db_insert(yesterday, "DRK");
		db_insert(yesterday, "DVC");
		db_insert(yesterday, "EAC");
		db_insert(yesterday, "ELC");
		db_insert(yesterday, "EMC2");
		db_insert(yesterday, "EXE");
		db_insert(yesterday, "FLAP");
		db_insert(yesterday, "FRC");
		db_insert(yesterday, "FRK");
		db_insert(yesterday, "FST");
		db_insert(yesterday, "FTC");
		db_insert(yesterday, "GLC");
		db_insert(yesterday, "GLD");
		db_insert(yesterday, "HBN");
		db_insert(yesterday, "HVC");
		db_insert(yesterday, "IFC");
		db_insert(yesterday, "IXC");
		db_insert(yesterday, "JKC");
		db_insert(yesterday, "KDC");
		db_insert(yesterday, "LEAF");
		db_insert(yesterday, "LKY");
		db_insert(yesterday, "LOT");
		db_insert(yesterday, "MAX");
		db_insert(yesterday, "MEC");
		db_insert(yesterday, "MEOW");
		db_insert(yesterday, "MINT");
		db_insert(yesterday, "MNC");
		db_insert(yesterday, "MRY");
		db_insert(yesterday, "MZC");
		db_insert(yesterday, "NET");
		db_insert(yesterday, "NMC");
		db_insert(yesterday, "NRB");
		db_insert(yesterday, "NVC");
		db_insert(yesterday, "NXT");
		db_insert(yesterday, "NYAN");
		db_insert(yesterday, "OSC");
		db_insert(yesterday, "PHS");
		db_insert(yesterday, "POT");
		db_insert(yesterday, "PPC");
		db_insert(yesterday, "PTS");
		db_insert(yesterday, "PXC");
		db_insert(yesterday, "QRK");
		db_insert(yesterday, "RDD");
		db_insert(yesterday, "RPC");
		db_insert(yesterday, "SAT");
		db_insert(yesterday, "SBC");
		db_insert(yesterday, "SMC");
		db_insert(yesterday, "SPA");
		db_insert(yesterday, "SRC");
		db_insert(yesterday, "SXC");
		db_insert(yesterday, "TAG");
		db_insert(yesterday, "TAK");
		db_insert(yesterday, "TRC");
		db_insert(yesterday, "UNO");
		db_insert(yesterday, "UTC");
		db_insert(yesterday, "VTC");
		db_insert(yesterday, "WDC");
		db_insert(yesterday, "XJO");
		db_insert(yesterday, "YAC");
		db_insert(yesterday, "YBC");
		db_insert(yesterday, "ZED");
		db_insert(yesterday, "ZET");
		db_insert(yesterday, "AUR");
		db_insert(yesterday, "BAT");
		db_insert(yesterday, "COL");
		db_insert(yesterday, "CTM");
		db_insert(yesterday, "FLO");
		db_insert(yesterday, "MOON");
		db_insert(yesterday, "RED");
		db_insert(yesterday, "TIPS");
		db_insert(yesterday, "TIX");
		db_insert(yesterday, "ZEIT");
		db_insert(yesterday, "BTC");
		db_insert(yesterday, "LTC");
        
        
	}
	
	
	
	public static void db_insert (String yesterday, String ticker) throws IOException{

		String average_price = null;
		
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
     		ResultSet rs = st.executeQuery("Select avg(`" + ticker + "`) From `daily_coin` where date between \"" 
     									+ yesterday + "\" AND \"" + currentTime + "\"");
     		
			if(rs.next()) { 
     		    average_price = rs.getString("avg(`" + ticker + "`)");
		    //System.out.println("price = " + average_price);
     		}
     		
     		float average_float = Float.parseFloat(average_price);
		//System.out.println("price = " + average_float);


     		Statement st2 = (Statement) connection.createStatement();
     		st2.executeUpdate("update history_table set `" + ticker + "` = " + average_float + " where date= \"" + yesterday + "\"");
        	
		//System.out.println("update history_table set `" + ticker + "` = " + average_float + " where date= \"" + yesterday + "\"");


        	connection.close();

        } catch (SQLException e) {
                e.printStackTrace();
                return;
        }


	}

}

