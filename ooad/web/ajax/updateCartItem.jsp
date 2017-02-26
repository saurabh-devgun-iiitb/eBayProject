<%@page import="dao.implementaion.CartDAOImplementation"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="dao.DBConnection"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%
		String result = "";
		String cart_item_id = request.getParameter("id");
		int cart_quantity = Integer.parseInt((String) request.getParameter("qty"));
		
		int cart_user_id = Integer.parseInt((String) session.getAttribute("surrogate"));
		
        try {
        	
        	String sql = "SELECT item_id FROM items WHERE items_id=" + cart_item_id + " AND item_quantity_available >= " + cart_quantity;	//	surrogate id
        	System.out.println(sql);
			PreparedStatement ps2 = new DBConnection().connect().prepareStatement(sql);
			ResultSet rs2 = ps2.executeQuery();
			
			if(rs2.next()) {
				sql = "SELECT item_price FROM items WHERE items_id=" + cart_item_id;	//	surrogate id
	        	System.out.println(sql);
				PreparedStatement ps = new DBConnection().connect().prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				if(rs.next()) {

					String usql;
					
					if(cart_quantity == 0) {
						usql = "DELETE FROM carts WHERE cart_item_id=" + cart_item_id + " AND cart_user_id="+cart_user_id;
						System.out.println(usql);
						PreparedStatement ups = new DBConnection().connect().prepareStatement(usql);
						ups.execute();
					    ups.close();
					}
					else {
						usql = "UPDATE carts SET cart_quantity=" + cart_quantity +", cart_price=" + cart_quantity * rs.getDouble(1) + 
								" WHERE cart_item_id=" + cart_item_id + " AND cart_user_id="+cart_user_id;
						System.out.println(usql);
						PreparedStatement ups = new DBConnection().connect().prepareStatement(usql);
						ups.execute();
					    ups.close();
				/* 
						DBConnection conn = new DBConnection();
			            PreparedStatement ps1 = conn.connect().prepareStatement("SELECT cart_quantity FROM carts WHERE cart_user_id = ? AND cart_item_id = ?");
			            ps1.setInt(1, Integer.parseInt((String) session.getAttribute("surrogate")));
			            ps1.setInt(2, Integer.parseInt(cart_item_id));
			            System.out.println(ps1.toString());
			            ResultSet rs1 = ps1.executeQuery();
			            ps.close();
			            conn.disconnect();	
				 */	}
					
				}
			   	ps.close();	
			   	response.sendRedirect("getCart");
			}
			else {
				result = "Invalid";
		        out.println(result);
			}
        }
	    catch(Exception e){
	        e.printStackTrace();
	    }
        
%>