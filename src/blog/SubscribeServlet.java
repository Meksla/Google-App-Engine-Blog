package blog;

import java.io.IOException;



import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyService;

import static com.googlecode.objectify.ObjectifyService.ofy;
import blog.entity.Subscriber;

@SuppressWarnings("serial")
public class SubscribeServlet extends HttpServlet {
   
	public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
        ObjectifyService.register(Subscriber.class);
        Objectify ofy = ObjectifyService.ofy();
		//Save the email address of Subscriber in email variable
		String email = req.getParameter("inputEmail");
		Subscriber subscriber= new Subscriber(email);
		ofy.save().entities(subscriber).now();
		final Long id = subscriber.id;
		assert id != null;
		
		
		
		//Send the subscriber back to homepage
		resp.sendRedirect("/myblog.jsp");
	}
}
