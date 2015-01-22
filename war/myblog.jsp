<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreServiceFactory" %>
<%@ page import="com.google.appengine.api.datastore.DatastoreService" %>
<%@ page import="com.google.appengine.api.datastore.Query" %>
<%@ page import="com.google.appengine.api.datastore.Entity" %>
<%@ page import="com.google.appengine.api.datastore.FetchOptions" %>
<%@ page import="com.google.appengine.api.datastore.Key" %>
<%@ page import="com.google.appengine.api.datastore.KeyFactory" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ page import="com.google.appengine.api.datastore.Text" %>

<html>
	<head>
		<link type="text/css" rel="stylesheet" href="/bootswatch.css" />
		<link type="text/css" rel="stylesheet" href="/foundation.css" />
	</head>
	
	<body>
<%
	UserService userService = UserServiceFactory.getUserService();
    User user = userService.getCurrentUser();
%>

 	<div class="row">
    <div class="large-12 columns">
    <div class="navbar navbar-default">
  	<div class="navbar-header">
    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
      <span class="icon-bar"></span>
    </button>
    <a class="navbar-brand" href="/myblog.jsp">Home</a>
  	</div>
  	<div class="navbar-collapse collapse navbar-responsive-collapse">
    <ul class="nav navbar-nav navbar-right">
<%	if(user != null) {
%>
	<li><a href="<%= userService.createLogoutURL(request.getRequestURI()) %>">Sign Out</a></li>
	<li><a href="/newentry.jsp">New Post</a></li>
<%
	} else{
%>
	<li><a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign In</a></li>
	<li><a href="<%= userService.createLoginURL(request.getRequestURI()) %>">Sign In to Post</a></li>
<%	}
%>
    </ul>
  	</div>
	</div>
	<div align="center">
	<img src="images/logo.png">
    </div>
  	</div>
  	</div>
 
   
 
 
   
 
 	<div class="row">
 
     
    <div class="large-9 columns" role="content">
     	<div class="panel panel-default">
  	<div class="panel-body">
 
 <%
 	DatastoreService datastore = DatastoreServiceFactory.getDatastoreService();
 	Key blogKey = KeyFactory.createKey("Blogpost", "blog");
 	Query query = new Query("Blogpost", blogKey).addSort("date", Query.SortDirection.DESCENDING);
 	List<Entity> posts = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(5));
 	if (posts.isEmpty()) {
        %>
        <article>
        <p>There are no Posts</p>
        <%
    } else {
          for (Entity post : posts) {
		pageContext.setAttribute("postuser", post.getProperty("user"));
		pageContext.setAttribute("postdate", post.getProperty("date"));
		pageContext.setAttribute("posttitle", ((Text) post.getProperty("title")).getValue());
		pageContext.setAttribute("postcontent", ((Text) post.getProperty("content")).getValue());
%>
		<article>
		<h3>${fn:escapeXml(posttitle)}</h3>
        <h6>Written by ${fn:escapeXml(postuser.nickname)} on ${fn:escapeXml(postdate)}</h6>
        <div class="row">
         <div class="large-6 columns">
         <p>${fn:escapeXml(postcontent)}</p>
         </article>
         <hr/>
<%
        }
    }
%>
	<div align="center">
	<a href="/showall.jsp" class="btn btn-primary">Show All Posts</a>
	</div>
	</div>
	</div>
	</div>
     
 
 
     
 
    <aside class="large-3 columns">
    <div class="list-group">
    <div class="list-group-item active" align="center">
    Related Links
 	</div>
  	<a href="http://na.leagueoflegends.com/" class="list-group-item">
    League of Legends
 	</a>
  	<a href="http://na.lolesports.com/" class="list-group-item">
  	LoL E-Sports
  	</a>
  	<a href="http://www.twitch.tv/riotgames" class="list-group-item">Riot's Twitch
 	</a>
	</div>
    
 	<br>
 	<div class="panel panel-primary">
 	<div class="panel-heading">
 	<div align="center">
 	<h3 class ="panel-title">Subscribe to our email updates!</h3>
 	 </div>
 	 </div>
   	<div class="panel-body" align="center">
  	<a href="/subscribe.jsp" class="btn btn-primary">Subscribe</a>
  	<br>
  	<br>
    <a href="unsubscribe.jsp" class="btn btn-primary">Unsubscribe</a>
	</div>
	</div>
 
    </aside>
   
 
  	<footer class="row">
    <div class="large-12 columns">
    <hr/>
    <p>Made By Max Sigrist and Antonio Jordao</p>
    </div>
  	</footer>
	</body>
</html>