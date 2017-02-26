package action;

import java.util.ArrayList;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dao.ReportDAO;
import dao.implementaion.ReportDAOImplementation;
import model.Report;

@SuppressWarnings("serial")
public class ReportAction extends ActionSupport implements ModelDriven<ArrayList <Report>> {
	
	ArrayList<Report> reports = new ArrayList<>();
	private int categoryId;
	private int subCategoryId;
   
	public String execute() {
		ReportDAO reportDAO = new ReportDAOImplementation();
		if(reportDAO.generateReport(categoryId,subCategoryId, reports))
			return SUCCESS;
		return ERROR;
	}
	
	

	@Override
	public ArrayList<Report> getModel() {
		// TODO Auto-generated method stub
		return reports;
	}



	public int getCategoryId() {
		return categoryId;
	}



	public void setCategoryId(int categoryId) {
		this.categoryId = categoryId;
	}



	public int getSubCategoryId() {
		return subCategoryId;
	}



	public void setSubCategoryId(int subCategoryId) {
		this.subCategoryId = subCategoryId;
	}


}
