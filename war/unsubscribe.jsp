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

<html>
	<head>
		<link type="text/css" rel="stylesheet" href="/bootswatch.css" />
		<link type="text/css" rel="stylesheet" href="/newentry.css" />
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
  	
	<div class="grid">
   <div class="panel panel-default">
  	<div class="panel-body">
  <form class="form-horizontal" action="/unsubscribeservlet" method="POST">
  <fieldset>
    <legend>Unsubscribe from Email Updates</legend>
    <div class="form-group">
      <label for="inputEmail" class="col-lg-2 control-label">Email</label>
      <div class="col-lg-7">
        <input type="text" class="form-control" name="inputEmail" placeholder="iloveleague@email.com">
        <span class="help-block">Enter your subscribed email to unsubscribe</span>
      </div>
    </div>
    <div class="form-group">
      	<div class="col-lg-5 col-lg-offset-2">
       	<a href="/myblog.jsp" class="btn btn-default">Cancel</a>
        <button type="Unsubscribe" class="btn btn-primary">Submit</button>
    	</div>
    </div>
  	</fieldset>
	</form>
    </div>
    </div>
    </div>
    
    <footer class="row">
    <div class="large-12 columns">
    <hr/>
    <p>Made By Max Sigrist and Antonio Jordao</p>
    </div>
  	</footer>
	</body>
    </body>
</html>