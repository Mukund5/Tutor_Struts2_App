<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="s" uri="/struts-tags" %>
	<%@ taglib prefix="sx" uri="/struts-dojo-tags" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<sx:head />
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>MyTutor</title>
<link href="images/horse.png" rel="shortcut icon" type="image/x-icon">
</head>

<link type="text/css" rel="stylesheet" href="css/tabMenuStyles.css"/>
<link type="text/css" rel="stylesheet" href="css/dataTables.jqueryui.css"/>
<link type="text/css" rel="stylesheet" href="css/dataTables.jqueryui.min.css"/>
<link type="text/css" rel="stylesheet" href="css/jquery.dataTables.css"/>
<link type="text/css" rel="stylesheet" href="css/jquery.dataTables.min.css"/>
<link type="text/css" rel="stylesheet" href="css/jquery.fancybox.css"/>

<script type="text/javascript" src="js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="js/jquery.dataTables.js"></script>
<%-- <script type="text/javascript" src="js/dataTables.jqueryui.js"></script> --%>
<script type="text/javascript" src="js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="js/jquery.fancybox.js"></script>




<script type="text/javascript">
var $=jQuery.noConflict();

function checkUserNameAvailable()
{
	var userName=jQuery("#regisUserId").val();
	//alert(userName);
	jQuery.ajax({
	    
		//Calling a action with parameters
		//url : "getName.do?parameter=value",
				
				//Calling an action which is present in package with no namespace
	    		url : "CheckUserName.action?signUpDTO.userId="+userName,
	    				
			    //Calling an action which is present in package with namespace
	    		//url : '<s:url action="getResultServiceUI" namespace="test"/>',
	    type : "POST",
	    success : function(data) {
	        // You'll get your response here
	      //  alert("result got:"+data);
	        if(data.trim().toLowerCase()=='success')
	        	alert("The given user name is available");
	        else
	        	alert("The given user name is not available");
	        //location.href="";
	    }

});
}


$('#signUpForm').submit(function() {

	alert("check1");

	$.each($('.signUpMandatory'),function() {
		   if ($(this).val().length == 0) {
		    alert('Fill all mandatory fields');
		   }
		});

	});

function validateForm()
{
	//alert("check3");
	jQuery(function($) {
		
		var promise=$.when(checkFilled());
		
		promise.done(function(result1){
			//alert("ya:"+result1);
			return result1;
		})
	});
	
	
}
function checkFilled()
{
	var $=jQuery.noConflict();
	var deferred=$.Deferred();
	var returnVar=false;
	jQuery(function($) {
		
		 $('.signUpMandatory').each(function () { 
			  //alert("blaaa:"+$(this).text());
			  if ($(this).val().length == 0) 
			    {
				//  alert('Fill all mandatory fields');
				  returnVar=false;
			    }
			}); 
		
		
	/* 	$.each($('.signUpMandatory'),function() {
			   if ($(this).val().length == 0) {
			    alert('Fill all mandatory fields');
			    returnVar=false;
			   }
			}); */
		//alert(returnVar);
		deferred.resolve(returnVar);
		});
	
	return deferred.promise();
}
$('document').ready(function(){  

	//alert("yos");
	jQuery(function($) {});

	function validateForm1()
	{
		alert("check");

		$.each($('.signUpMandatory'),function() {
			   if ($(this).val().length == 0) {
			    alert('Fill all mandatory fields');
			   }
			});
		return true;
	}
	var $= jQuery.noConflict();
	$(".fancybox").fancybox({
        'autoScale': true,
        'transitionIn': 'elastic',
        'transitionOut': 'elastic',
        'speedIn': 500,
        'speedOut': 300,
        'autoDimensions': true,
        'centerOnScroll': true
    });
	$("#searchBtn").click(function()
			{

		/* Calling an action and getting response as json can be done using below call method */
		
		  $.getJSON(

				'listTutorials.action',
				
				/* If any parameters to action call it can be sent as below */ 
				/* {
					'phoneNumber':$("#phoneNumber").val()
				
				}, */
					function(jsonResponse) {


					if(jsonResponse==undefined || jsonResponse=='')
					{
						//write code to redirect to error page
						
					}
					else {
						
						//This is the variable that we have put in jsonObject in actionclass
						var tutorialsList=jsonResponse.tutorialsMasterList;
					
						if(tutorialsList==undefined || tutorialsList=='')
						{
							//write code to redirect to error page
							
						}
						else
							{
							
							//Form ui using datatable as below
							
							$("#tutorialsTable").show();
							$("#tutorialsTableHeading").html('Courses List');
							
							/* These columns should be as same as in DTO */
							var columns = ["courseName","courseDuration","courseFee","tutorName","courseDomain"];
							
					    	var dataTableObj = {
					    		bJQueryUI: true,
						        bAutoWidth: false,
						        bFilter:false,
						       bLengthChange: false,
						       bPaginate: true,
						       bSort: true,
						       iDisplayLength: 10,
						       bInfo: true,
						       bDestroy: true,
						       aaSorting: [],
					    	   aaData: [],
					    	   oLanguage: {"sZeroRecords": "", "sEmptyTable": "Records Not Available!! "},
					    	   aoColumns: [{  "sTitle": "Course Name","sClass": "veticalAlign"},
					 	                  {"sTitle": "Course Duration","sClass": "veticalAlign"},
					 	                 { "sTitle": "Course Fee","sClass": "veticalAlign"},
					 	                { "sTitle": "Tutor","sClass": "veticalAlign"},
					 	               { "sTitle": "Course Domain","sClass": "veticalAlign"}]
					    	};
					    	
					    	// Stuff the aaData array by iterating the tutorialsList from jsonresponse
					    	for (var i=0; i < tutorialsList.length; i++) {
					    	    var row = tutorialsList[i];
					    	    var dataTableRow = [];
					    	    for (var j=0; j < columns.length; j++) {
					    	    	if(row[columns[j]]==null)
					    	    		dataTableRow.push("---");
					    	    	else
					    	        dataTableRow.push(row[columns[j]]);
					    	    }
					    	    dataTableObj.aaData.push(dataTableRow);
					    	}
					    	$('#tutorialListResults').dataTable(dataTableObj);

							
							
							}
							}
					


			}).error(function() {
				//$('.overlayIRImage,#overlayMask').remove();
				//cl.hide();
		alert("An error has occurred! Please Login Again.");
		 /* window.location.href="/SLIC/jsps/sessionexpiry.jsp"; */ 
		/*  var appContext = $("#appContext").val();
		 alert(appContext);
		window.location.href=appContext+"/SignOutAction.action?"; */ 
		 window.location.href = "SignOutAction.action?"; 
	});	
						
		
			});

	
	
	
    });  
</script>
<style>
/* form {
  margin:0 auto;
  width:300px
}
input {
  margin-bottom:3px;
  padding:10px;
  width: 100%;
  border:1px solid #CCC
}
button {
  padding:10px
}
label {
  cursor:pointer
}
#form-switch {
  display:none
}
#register-form {
  display:none
}
#form-switch:checked~#register-form {
  display:block
}
#form-switch:checked~#login-form {
  display:none
}

.tableHeading{
font-weight:bold;
font-size:30px;
position: relative;
top: 4%;
color: bisque
}
 */
 
 
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
<body>

<h1 >My Tutor</h1></div> 

<s:form id="signUpForm" validate="true" onsubmit="return validateForm()"  action="CreateNewUser"   >
<s:textfield requiredLabel="true" cssClass="signUpMandatory" id="regisUserId" name="signUpDTO.userId" label="User name"></s:textfield>

<input type="button" onclick="checkUserNameAvailable()" value="Check Username Availability" >
<s:textfield type="password" requiredLabel="true" cssClass="signUpMandatory" id="regisUserPwd" name="signUpDTO.password" label="Password"></s:textfield>
<s:textfield  requiredLabel="true" cssClass="signUpMandatory" id="regisUserPwd2" name="signUpDTO.rePassword" label="Retype Password"></s:textfield>
<s:select requiredLabel="true" cssClass="signUpMandatory" headerKey="" headerValue="Select Category" id="regisUserCategory" label="Category" name="signUpDTO.userCategory" list="userCategories"></s:select>
<%-- <s:textfield requiredLabel="true" cssClass="signUpMandatory" id="regisDob" name="signUpDTO.dob" label="Date Of Birth"></s:textfield> --%>
<sx:datetimepicker requiredLabel="true" cssClass="signUpMandatory" id="regisDob" name="signUpDTO.dob" label="Date of Birth(yyyy-mm-dd)" displayFormat="yyyy-MM-dd"></sx:datetimepicker>
 
<s:textfield id="regisAddress" name="signUpDTO.address" label="Address"></s:textfield>
<s:textfield cid="regisEducation" name="signUpDTO.education" label="Education"></s:textfield>
<s:textfield requiredLabel="true" cssClass="signUpMandatory" id="regisMobile" name="signUpDTO.mobileNumber" label="Mobile Number"></s:textfield>
<s:select id="regisGender" name="signUpDTO.gender" label="Gender" list="#{'Male':'Male', 'Female':'Female', 'Others':'Others'}"></s:select>
<%-- <s:textfield id="regisGender" name="signUpDTO.gender" label="Gender"></s:textfield> --%>
<s:submit name="sub"  ></s:submit>
   </s:form>
   
   <p class="message">Have an Account? 

<s:url namespace="/login" id="loginUser" action="LoginAction" var="loginUserLink">
<%-- 	<s:param name="user">Zara</s:param> --%>
</s:url>

<a href='<s:property value="#loginUserLink"/>'>Login to your Account</a></p>
   
   
<div id="tutorialsTable" style="display:none;">
	<span id="tutorialsTableHeading" class="tableHeading"></span>
	<table id="tutorialListResults"	style="margin: 7px 5px 5px 2px" class="record"></table>
</div>

<br>
<%-- <s:label>Name:</s:label><s:textfield value="Enter Text"></s:textfield>
 --%>
 </body>  
</html>



