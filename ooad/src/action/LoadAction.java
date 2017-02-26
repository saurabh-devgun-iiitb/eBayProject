package action;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import model.Category;
import dao.CategoryDAO;
import dao.implementaion.CategoryDAOImplementation;

@SuppressWarnings("serial")
public class LoadAction extends ActionSupport implements ModelDriven<ArrayList<Category>> {

	private ArrayList<Category> categories = new ArrayList<>();
//	private TreeMap<String, ArrayList<String>> category = new TreeMap<>();
	
	public String execute() {
		CategoryDAO cs = new CategoryDAOImplementation();
		if(cs.getCategories(categories)) {
			HttpSession session=ServletActionContext.getRequest().getSession(false);  
	        if(session==null || session.getAttribute("login")==null || session.getAttribute("login").equals("deleted")){  
	            return SUCCESS;  
	        }  
			return LOGIN;
		}
		return ERROR;
	}
	
	public String getCategories() {
		CategoryDAO cs = new CategoryDAOImplementation();
		if(cs.getCategories(categories)) {
			return SUCCESS;
		}
		return ERROR;
	}
	
	@Override
	public ArrayList<Category> getModel() {
		// TODO Auto-generated method stub
		return categories;
	}
	
}
