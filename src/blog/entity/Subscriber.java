package blog.entity;

import java.util.Date;
 
import com.google.appengine.api.users.User;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;
 
 
@Entity
public class Subscriber implements Comparable<Subscriber> {
    @Id
	public Long id;
    String email;
    Date date;
    
    private Subscriber() {}
    public Subscriber(String email) {
        this.email = email;
        date = new Date();
    }
    public String getEmail() {
        return email;
    }
    
    public Date getDate(){
    	return date;
    }
    
    @Override
    public int compareTo(Subscriber other) {
        if (date.after(other.date)) {
            return 1;
        } else if (date.before(other.date)) {
            return -1;
        }
        return 0;
    }
}