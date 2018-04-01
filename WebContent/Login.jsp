<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login</title>

<script src="js/jquery-3.2.1.js" type="text/javascript"></script>
<style>

.mainHead h1 {
	font-size: 36px;
	line-height: 40px;
	margin: 1em 0 .6em 0;
	font-weight: normal;
	color: white;
	font-family: 'Hammersmith One', sans-serif;
	text-shadow: 0 -1px 0 rgba(0,0,0,0.4);
	position: relative;
	color: #F2F2F2;
	text-align:center;
}
.login-page {
  width: 100%;
  padding: 2% 0 0;
  margin: auto;
}
.form {
  position: relative;
  z-index: 1;
  background: #FFFFFF;
  max-width: 30%;
  margin: 0 auto 10%;
  padding: 5%;
  text-align: center;
  box-shadow: 0 0 20px 0 rgba(0, 0, 0, 0.2), 0 5px 5px 0 rgba(0, 0, 0, 0.24);
}
.myLabel{
margin-top:7%;
color: #B4886B;
font-weight: bold;
display: block;
/* width: 150px; */
float: left;
}
.form input {
  font-family: "Roboto", sans-serif;
  outline: 0;
  background: #d4d0d0;
  width: 65%;
  border: 0;
  margin: 10px 0 15px;
  padding: 5%;
  box-sizing: border-box;
  font-size: 14px;
}

.formButton {
  font-family: "Roboto", sans-serif;
  text-transform: uppercase;
  outline: 0;
  background: #4CAF50 !important;
  width: 100%;
  border: 0;
  padding: 15px;
  color: #FFFFFF;
  font-size: 14px;
  -webkit-transition: all 0.3 ease;
  transition: all 0.3 ease;
  cursor: pointer;
}
.form button {
  font-family: "Roboto", sans-serif;
  text-transform: uppercase;
  outline: 0;
  background: #4CAF50;
  width: 100%;
  border: 0;
  padding: 5%;
  color: #FFFFFF;
  font-size: 14px;
  -webkit-transition: all 0.3 ease;
  transition: all 0.3 ease;
  cursor: pointer;
}
.form button:hover,.form button:active,.form button:focus {
  background: #43A047;
}
.formButton:hover,.formButton:active,.formButton:focus {
  background: #2b8e2f !important;
}
.form .message {
  margin: 15px 0 0;
  color: #b3b3b3;
  font-size: 12px;
}
.form .message a {
  color: #4CAF50;
  text-decoration: none;
}
.form .register-form {
  display: none;
}
.container {
  position: relative;
  z-index: 1;
  max-width: 40%;
  margin: 0 auto;
}
.container:before, .container:after {
  content: "";
  display: block;
  clear: both;
}
.container .info {
  margin: 10% auto;
  text-align: center;
}
.container .info h1 {
  margin: 0 0 15px;
  padding: 0;
  font-size: 36px;
  font-weight: 300;
  color: #1a1a1a;
}
.container .info span {
  color: #4d4d4d;
  font-size: 12px;
}
.container .info span a {
  color: #000000;
  text-decoration: none;
}
.container .info span .fa {
  color: #EF3B3A;
}
body {
  background: #76b852; /* fallback for old browsers */
  background: -webkit-linear-gradient(right, #76b852, #8DC26F);
  background: -moz-linear-gradient(right, #76b852, #8DC26F);
  background: -o-linear-gradient(right, #76b852, #8DC26F);
  background: linear-gradient(to left, #76b852, #8DC26F);
  font-family: "Roboto", sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;      
}


</style>
<script type="text/javascript">
$('.message a').click(function(){
	   $('form').animate({height: "toggle", opacity: "toggle"}, "slow");
	});
	
function callResultPage1()
{
	$.ajax({
	    
		//Calling a action with parameters
		//url : "getName.do?parameter=value",
				
				//Calling an action which is present in package with no namespace
	    		//url : "getResult.action?",
	    				
			    //Calling an action which is present in package with namespace
	    		url : '<s:url action="getResult" namespace="test"/>',
	    type : "POST",
	    success : function(data) {
	        // You'll get your response here
	        //alert(data);
	        this.HTML=data;
	    }

});
}
function callResultPage2()
{
	$.ajax({
	    
		//Calling a action with parameters
		//url : "getName.do?parameter=value",
				
				//Calling an action which is present in package with no namespace
	    		//url : "getResult.action?",
	    				
			    //Calling an action which is present in package with namespace
	    		url : '<s:url action="getResultService" namespace="test"/>',
	    type : "POST",
	    success : function(data) {
	        // You'll get your response here
	        alert(data);
	    }

});
}
function callResultPage3()
{
	$.ajax({
	    
		//Calling a action with parameters
		//url : "getName.do?parameter=value",
				
				//Calling an action which is present in package with no namespace
	    		//url : "getResult.action?",
	    				
			    //Calling an action which is present in package with namespace
	    		url : '<s:url action="getResultServiceUI" namespace="test"/>',
	    type : "POST",
	    success : function(data) {
	        // You'll get your response here
	        //alert(data);
	        location.href="";
	    }

});
}
</script>

</head>
<body>
<div class="mainHead">
<h1 >My Tutor</h1></div>
<div class="login-page">
  <div class="form">
    <form class="register-form">
      <input type="text" placeholder="name"/>
      <input type="password" placeholder="password"/>
      <input type="text" placeholder="email address"/>
      <button>create</button>
      <p class="message">Already registered? <a href="#">Sign In</a></p>
    </form>
    <!-- <form class="login-form">
      <input type="text" placeholder="username"/>
      <input type="password" placeholder="password"/>
      <button>login</button>
      <p class="message">Not registered? <a href="#">Create an account</a></p>
    </form> -->
    
    <s:form action="LoginAction" namespace="/login" method="post" cssClass="login-form">
<s:label cssClass="myLabel" value="User ID" theme="simple"></s:label>&nbsp&nbsp&nbsp&nbsp<s:textfield name="loginUserId" cssClass="formInput" value="" labelSeparator="" theme="simple"></s:textfield>
<br><s:label cssClass="myLabel" value="Password" theme="simple"></s:label><s:password name="loginPassword"  cssClass="formInput" value="" labelSeparator="" theme="simple"></s:password>
<s:submit label="Submit" cssClass="formButton" theme="simple"></s:submit>

</s:form>
<p class="message">Not registered? 

<s:url namespace="/" id="createUser" action="SignUpAction" var="createUserLink">
<%-- 	<s:param name="user">Zara</s:param> --%>
</s:url>

<a href='<s:property value="#createUserLink"/>'>Create an Account</a></p>

<p class="message">Have an Account? 

<s:url namespace="/login" id="loginUser" action="LoginAction" var="loginUserLink">
<%-- 	<s:param name="user">Zara</s:param> --%>
</s:url>

<a href='<s:property value="#loginUserLink"/>'>Login to your Account</a></p>
<!-- <a href="/SignUpAction.action">Create an account</a></p> -->    
  </div>
</div>

</body>
</html>