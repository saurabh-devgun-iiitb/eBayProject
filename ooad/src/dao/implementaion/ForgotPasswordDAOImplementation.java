package dao.implementaion;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import com.opensymphony.xwork2.ActionSupport;

import dao.DBConnection;
import dao.ForgotPasswordDAO;
import model.Report;

@SuppressWarnings("serial")
public class ForgotPasswordDAOImplementation extends ActionSupport implements ForgotPasswordDAO {
	
	//for email
	 private String from;
	   private String password;
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

	@Override
	public boolean sendPassword(String email) {
		String sql;
		try
		{  	sql = "SELECT * FROM users where user_email = \'"+ email+"\'";
			System.out.println(sql);
			DBConnection cs = new DBConnection();
			PreparedStatement ps = cs.connect().prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			
			if(rs.next())
			{
				
				try
			      {System.out.println("Inside rs");
					setFrom("ooadraps@gmail.com");
					setPassword("raps1234");
					setTo(email);
					setSubject("Password Recovery");
					setBody("Hello "+rs.getString(3)+" your password is "+rs.getString(5)+".\n"+"Thank you for using Raps.in.");
			         Session session = Session.getDefaultInstance(properties,  
			            new javax.mail.Authenticator() {
			            protected PasswordAuthentication 
			            getPasswordAuthentication() {
			            return new 
			            PasswordAuthentication(from, password);
			            }});

			         Message message = new MimeMessage(session);
			         message.setFrom(new InternetAddress(from));
			         message.setRecipients(Message.RecipientType.TO, 
			            InternetAddress.parse(to));
			         message.setSubject(subject);
			         message.setText(body);
			         Transport.send(message);
			         return true;
			      }
			      catch(Exception e)
			      {
			         e.printStackTrace();
			      }
						
			}
			System.out.println("Returning false");
			return false;
		}
		catch(Exception e)
		{
			e.printStackTrace();
			return false;
		}

	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
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
