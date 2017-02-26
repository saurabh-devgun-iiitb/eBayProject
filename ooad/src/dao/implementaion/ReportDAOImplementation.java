package dao.implementaion;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import dao.DBConnection;
import dao.ReportDAO;
import model.Report;

public class ReportDAOImplementation implements ReportDAO {

	@Override
	public boolean generateReport(int cat_id,int subcat_id,ArrayList<Report> reports) {
		
		
		String sql;
		try
		{   if(subcat_id != 0)
			sql = "SELECT * FROM report where item_cat_id = "+cat_id+" AND item_subcat_id ="+subcat_id;
			else
				sql = "SELECT * FROM report where item_cat_id = "+cat_id;
			System.out.println(sql);
			DBConnection cs = new DBConnection();
			PreparedStatement ps = cs.connect().prepareStatement(sql);
			/*ps.setInt(1, cat_id);
			ps.setInt(2, subcat_id);*/
			ResultSet rs = ps.executeQuery();
			
			while(rs.next())
			{
				Report report = new Report();
				report.setItem_id(rs.getString(1));
				report.setItem_name(rs.getString(2));
				report.setSeller_name(rs.getString(6));
				
				reports.add(report);
				
			}
			
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return false;
		}
		
		
		// TODO Auto-generated method stub
		return true;
	}
	
	

}
