package blog;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.Key;
import com.google.appengine.api.datastore.KeyFactory;
import com.google.appengine.api.users.User;
import com.google.appengine.api.users.UserService;
import com.google.appengine.api.users.UserServiceFactory;
import com.google.appengine.api.datastore.Text;

public class NewBlogEntryServlet extends HttpServlet {
    public void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
		UserService userService = UserServiceFactory.getUserService();
		User user = userService.getCurrentUser();
		
		
		Text entryTitle = new Text(req.getParameter("inputTitle"));
		Key blogKey = KeyFactory.createKey("Blogpost", "blog");
		Text content = new Text(req.getParameter("inputContent"));
		Date date = new Date();
		Entity blogPost = new Entity("Blogpost", blogKey);
		blogPost.setProperty("title", entryTitle);
		blogPost.setProperty("user", user);
		blogPost.setProperty("date", date);
		blogPost.setProperty("content", content);

		DatastoreService datastore = DatastoreServiceFactory
				.getDatastoreService();
		datastore.put(blogPost);

		resp.sendRedirect("/myblog.jsp");
	}
}
