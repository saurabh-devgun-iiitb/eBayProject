package dao;

import java.util.ArrayList;

import model.Report;

public interface ReportDAO {
	
   public boolean generateReport(int cat_id,int subcat_id, ArrayList<Report> reports);

}
