<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Index Page</title>

<script src="js/jquery-3.2.1.js" type="text/javascript"></script>
<script type="text/javascript">
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
<input type="button" id="firstpage" onclick="callResultPage1()" value="Page1">
<input type="button" id="secondpage" onclick="callResultPage2()" value="Page2">
<input type="button" id="thirdpage" onclick="callResultPage3()" value="Page3">
<s:property value="resultUniversity"/>
</body>
</html>