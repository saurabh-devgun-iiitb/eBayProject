package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBConnection {
	
    // init database constants
    private static final String DATABASE_DRIVER = "com.mysql.jdbc.Driver";
    private static final String DATABASE_URL = "jdbc:mysql://localhost:3306/ebay";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "";
    private static final String MAX_POOL = "250";

    public static final String ITEMS_TABLE = "items";
    public static final String USERS_TABLE = "users";
    public static final String BUYERS_TABLE = "buyers";
    public static final String SELLERS_TABLE = "sellers";
    public static final String DEALS_TABLE = "deals";
    public static final String CARTS_TABLE = "carts";
    public static final String LOGS_TABLE = "logs";
    public static final String ATTRIBUTES_TABLE = "items";
    public static final String CATEGORIES_TABLE = "categories";
    public static final String SUBCATEGORIES_TABLE = "subcategories";
    public static final String CAT_SUBCAT_TABLE = "categories_subcategories";
    
    public static final String CAT_SUBCAT_VIEW = "cat_subcat";
    public static final String REPORT_VIEW = "report";
    
    // init connection object
    private Connection connection;
    // init properties object
    private Properties properties;

    // create properties
    private Properties getProperties() {
        if (properties == null) {
            properties = new Properties();
            properties.setProperty("user", USERNAME);
            properties.setProperty("password", PASSWORD);
            properties.setProperty("MaxPooledStatements", MAX_POOL);
        }
        return properties;
    }

    // connect database
    public Connection connect() {
        if (connection == null) {
            try {
                Class.forName(DATABASE_DRIVER);
                connection = DriverManager.getConnection(DATABASE_URL, getProperties());
//                System.out.println("Connection Established");
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
            }
        }
        return connection;
    }

    // disconnect database
    public void disconnect() {
        if (connection != null) {
            try {
                connection.close();
                connection = null;
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}