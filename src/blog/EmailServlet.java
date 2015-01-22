package blog;

import java.io.IOException;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.logging.Logger;

import javax.jdo.PersistenceManager;
import javax.jdo.Query;
import javax.mail.Address;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import blog.entity.Subscriber;

import com.google.appengine.api.datastore.*;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.googlecode.objectify.ObjectifyService;



@SuppressWarnings("serial")
public class EmailServlet extends HttpServlet{
		
	public static final Logger _log = Logger.getLogger(EmailServlet.class.getName());
		
	public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
			Properties props = new Properties();
			Session session = Session.getDefaultInstance(props, null);
			Date date = new Date();
			
			
			ObjectifyService.register(Subscriber.class);
			List<Subscriber> subscribers = ObjectifyService.ofy().load().type(Subscriber.class).list();   
			Collections.sort(subscribers); 

			try{
				Iterator iterator = subscribers.iterator();
			

				while(iterator.hasNext()){
						Subscriber s = (Subscriber) iterator.next();
						
						//Email
						String strCallResult = "Hello this is the email you subscribed to receive. Here are today's updates: \n\n\n";
						DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
					 	Key blogKey = KeyFactory.createKey("Blogpost", "blog");
					 	com.google.appengine.api.datastore.Query query = new com.google.appengine.api.datastore.Query("Blogpost", blogKey).addSort("date", com.google.appengine.api.datastore.Query.SortDirection.DESCENDING);
					 	List<Entity> posts = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(100000));
					 	int i = 0;
					 	if (posts.isEmpty()) {
					 		strCallResult += "\n There were no New Posts Today";
					 	}else{
					 		for (Entity post : posts) {
					 			if(date.getTime()  - ((Date) post.getProperty("date")).getTime() < 1000*60*60*24){
					 				i = 1;
					 				strCallResult +="Title: " + ((Text)post.getProperty("title")).getValue() + "\n"
					 						+ "By: " + ((User) post.getProperty("user")).getNickname() + "\n"
					 						+ "On: " + ((Date) post.getProperty("date")) + "\n"
					 						+ "Content: " + ((Text)post.getProperty("content")).getValue() + "\n"
					 						+ "\n\n";
					 			}
					 		}
					 		if(i == 0){
					 			strCallResult += "\n There were no New Posts Today";
					 		}
					 	}
						//Send out Email
						MimeMessage outMessage = new MimeMessage(session);
						outMessage.setFrom(new InternetAddress("DailyReport@lolworldchampionship.appspotmail.com"));
						outMessage.addRecipient(MimeMessage.RecipientType.TO, new InternetAddress(s.getEmail()));
						outMessage.setSubject("LoL World's Championship Blog");
						outMessage.setText(strCallResult);
						Transport.send(outMessage);
						
				}
			}
			catch (MessagingException e) { 
				_log.info("Cron Job has been executed" + e.getMessage());
			}
	} 
	
	@Override
	public void doPost(HttpServletRequest req, HttpServletResponse resp)
	throws ServletException, IOException {
	doGet(req, resp);
	}
}
		
	


	

