package blog;

import java.io.IOException;
import java.util.Collections;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.googlecode.objectify.Objectify;
import com.googlecode.objectify.ObjectifyService;

import blog.entity.Subscriber;

@SuppressWarnings("serial")
public class UnsubscribeServlet extends HttpServlet {
    public void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
		
		String email = req.getParameter("inputEmail");
	
        ObjectifyService.register(Subscriber.class);
        Objectify ofy = ObjectifyService.ofy();
		List<Subscriber> subscribers = ObjectifyService.ofy().load().type(Subscriber.class).list();   
		Collections.sort(subscribers);
		Iterator iterator = subscribers.iterator();
		while(iterator.hasNext()){
			Subscriber s = (Subscriber) iterator.next();
			if(s.getEmail().equals(email)){
				ofy.delete().entity(s);
			}
		}
		resp.sendRedirect("/myblog.jsp");
	}
	
}

