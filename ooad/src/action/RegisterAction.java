package action;

import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import dao.RegisterDAO;
import dao.implementaion.RegisterDAOImplementation;
import model.Seller;
import model.User;

@SuppressWarnings("serial")
public class RegisterAction extends ActionSupport implements ModelDriven<Seller> {

	private Seller seller = new Seller();
	
	private String id;
	private String email;
	private String password;
	private String firstName;
	private String lastName;
	
	//for email 
	
	private String from;
	   private String pwd;
	   private String to;
	   private String subject;
	   private String body;
	   
	   static Properties properties = new Properties();
	   static
	   {
	      properties.put("mail.smtp.host", "smtp.gmail.com");
	      properties.put("mail.smtp.socketFactory.port", "465");
	      properties.put("mail.smtp.socketFactory.class",
	                     "javax.net.ssl.SSLSocketFactory");
	      properties.put("mail.smtp.auth", "true");
	      properties.put("mail.smtp.port", "465");
	   }
	
	private User user = new User();
	
	public String execute() {
		
		try
	      {
			setFrom("ooadraps@gmail.com");
			setPwd("raps1234");
			setTo(seller.getSellerEmail());
			setSubject("Seller Registration Sucessfull");
			setBody("Welcome "+seller.getSellerName()+" to Raps.in");
	         Session session = Session.getDefaultInstance(properties,  
	            new javax.mail.Authenticator() {
	            protected PasswordAuthentication 
	            getPasswordAuthentication() {
	            return new 
	            PasswordAuthentication(from, pwd);
	            }});

	         Message message = new MimeMessage(session);
	         message.setFrom(new InternetAddress(from));
	         message.setRecipients(Message.RecipientType.TO, 
	            InternetAddress.parse(to));
	         message.setSubject(subject);
	         message.setText(body);
	         Transport.send(message);
	      }
	      catch(Exception e)
	      {
	         e.printStackTrace();
	      }
		
		RegisterDAO registerDAO = new RegisterDAOImplementation();
		if(registerDAO.registerSeller(seller))
			return SUCCESS;
		return ERROR;
	}
	
	public String executeUser(){
		
		try
	      {
			setFrom("ooadraps@gmail.com");
			setPwd("raps1234");
			setTo(email);
			setSubject("User Registration Sucessfull");
			setBody("Welcome "+firstName+" "+lastName+" to Raps.in");
	         Session session = Session.getDefaultInstance(properties,  
	            new javax.mail.Authenticator() {
	            protected PasswordAuthentication 
	            getPasswordAuthentication() {
	            return new 
	            PasswordAuthentication(from, pwd);
	            }});

	         Message message = new MimeMessage(session);
	         message.setFrom(new InternetAddress(from));
	         message.setRecipients(Message.RecipientType.TO, 
	            InternetAddress.parse(to));
	         message.setSubject(subject);
	         message.setText(body);
	         Transport.send(message);
	      }
	      catch(Exception e)
	      {
	         e.printStackTrace();
	      }
		
		user.setUserId(id);
		user.setUserEmail(email);
		user.setUserPassword(password);
		user.setUserName(firstName+" "+lastName);
		System.out.println(email);
		RegisterDAO registerDAO = new RegisterDAOImplementation();
		if(registerDAO.registerUser(user))
			return SUCCESS;
		return ERROR;
		
	}
	public String registerUser() {
		return SUCCESS;
	}
	
	@Override
	public Seller getModel() {
		return seller;
	}
	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getTo() {
		return to;
	}

	public void setTo(String to) {
		this.to = to;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getBody() {
		return body;
	}

	public void setBody(String body) {
		this.body = body;
	}

}
