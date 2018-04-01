<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>MyTutor</title>
<link href="../images/horse.png" rel="shortcut icon" type="image/x-icon">
</head>

<link type="text/css" rel="stylesheet" href="../css/tabMenuStyles.css"/>
<link type="text/css" rel="stylesheet" href="../css/dataTables.jqueryui.css"/>
<link type="text/css" rel="stylesheet" href="../css/dataTables.jqueryui.min.css"/>
<link type="text/css" rel="stylesheet" href="../css/jquery.dataTables.css"/>
<link type="text/css" rel="stylesheet" href="../css/jquery.dataTables.min.css"/>
<link type="text/css" rel="stylesheet" href="../css/jquery.fancybox.css"/>

<script type="text/javascript" src="../js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="../js/jquery.dataTables.js"></script>
<%-- <script type="text/javascript" src="../js/dataTables.jqueryui.js"></script> --%>
<script type="text/javascript" src="../js/jquery.dataTables.min.js"></script>
<script type="text/javascript" src="../js/jquery.fancybox.js"></script>




<script type="text/javascript">


$('document').ready(function(){  

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
					 	               { "sTitle": "Course Domain","sClass": "veticalAlign"},
					 	              { "sTitle": "Payment","sClass": "veticalAlign"}]
					    	};
					    	
					    	// Stuff the aaData array by iterating the tutorialsList from jsonresponse
					    	for (var i=0; i < tutorialsList.length; i++) {
					    	    var row = tutorialsList[i];
					    	    var dataTableRow = [];
					    	    var tranAmt="";
					    	    for (var j=0; j < columns.length+1; j++) {

					    	    	if(j==2)
					    	    		{
					    	    		tranAmt=row[columns[j]];
					    	    		<s:set name='myTestVar' value="+tranAmnt+"></s:set>
					    	    		//alert("tran amt:"+tranAmt);
					    	    		}
					    	    	if(j==columns.length)
					    	    		{

					    	    		dataTableRow.push("<a onclick='makePayment()'>Proceed to Payment</a>");
					    	    		
					    	    		}
					    	    	else if(row[columns[j]]==null)
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
    
    function makePayment()
    {
    	alert("hiii");
    	
    	
//    	var myTbl=$('#tutorialListResults').dataTable();
    	
    	
    	
    	
    	
    	/* $.ajax({
    		
    		type:"POST",
    		
    		
    	}); */
    	
    	//dataTableRow.push("<s:url namespace='/' action='proceedToPayment' var='makePaymentLink'> <s:param name='transactionAmount'><s:property value='%{myTestVar}'/></s:param> </s:url><a href='<s:property value='#makePaymentLink'/>'>Proceed to Payment</a>");
    	
    }
</script>
<style>

.tableHeading{
font-weight:bold;
font-size:30px;
position: relative;
top: 4%;
color: bisque
}
</style>
<body>

<div id='cssmenu'>
<ul>
   <li><a href='#'><span>Home</span></a></li>
   <li class='active has-sub'><a href='#'><span>Products</span></a>
      <ul>
         <li class='has-sub'><a href='#'><span>Product 1</span></a>
            <ul>
               <li><a href='#'><span>Sub Product</span></a></li>
               <li class='last'><a href='#'><span>Sub Product</span></a></li>
            </ul>
         </li>
         <li class='has-sub'><a href='#'><span>Product 2</span></a>
            <ul>
               <li><a href='#'><span>Sub Product</span></a></li>
               <li class='last'><a href='#'><span>Sub Product</span></a></li>
            </ul>
         </li>
      </ul>
   </li>
<%--    <li><a class="fancybox" href='../images/scenery.jpg'><span>About</span></a></li> --%>
<li><a class="fancybox" href='../images/scenery.jpg'><span>About</span></a></li>
   
   <li class='last'><a href='#'><span>Contact</span></a></li>
</ul>
</div>
<input type="button" id="searchBtn" value="Search"></input>   
<div id="tutorialsTable" style="display:none;">
	<span id="tutorialsTableHeading" class="tableHeading"></span>
	<table id="tutorialListResults"	style="margin: 7px 5px 5px 2px" class="record"></table>
</div>

<br>

<s:url namespace="/" action="proceedToPayment" var="makePaymentLink">
 	<s:param name="transactionAmount" value="13566"></s:param> 
</s:url>

<a href='<s:property value="#makePaymentLink"/>'>Proceed to Payment</a>

<s:url namespace="/" action="proceedToPayment" var="makePaymentLink">
 	<s:param name="transactionAmount">135617</s:param> 
</s:url>

<a href='<s:property value="#makePaymentLink"/>'>Proceed to Payment</a>

<s:url namespace="/" action="proceedToPayment" var="makePaymentLink">
<s:set name="myTestVar" value="54"></s:set>
 	<s:param name="transactionAmount" value="myTestVar"></s:param> 
</s:url>

<a href='<s:property value="#makePaymentLink"/>'>Proceed to Payment</a>


<%-- <s:label>Name:</s:label><s:textfield value="Enter Text"></s:textfield>
 --%>
 </body>  
</html>



