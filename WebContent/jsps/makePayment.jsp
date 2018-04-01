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


<script type="text/javascript" src="js/jquery-3.2.1.js"></script>
<%-- <script type="text/javascript" src="../js/jquery.dataTables.js"></script> --%>
<%-- <script type="text/javascript" src="../js/dataTables.jqueryui.js"></script> --%>
<%-- <script type="text/javascript" src="../js/jquery.dataTables.min.js"></script> --%>
<%-- <script type="text/javascript" src="../js/jquery.fancybox.js"></script> --%>




<script type="text/javascript">


function isNumber(event)
{
	var charcode = (event.which) ? event.which : event.keyCode;

		//alert(charcode);

		 if((charcode >= 48 && charcode <= 57)||(charcode ==8)||(charcode ==127)||(charcode ==35)||(charcode ==36)||(charcode ==37)||(charcode ==39)||(charcode ==46))
			{
			
		
			return true;
			}
		 return false;
}
function oned()
{
	
	alert("11");
}
function fetchBalance1()
{

	var paymentMode=jQuery('input:radio[name=transactionMode]:checked').val();
	var acctNum=jQuery('#paymentNumber').val();
	if(acctNum.length==0)
	alert("Enter a valid number");	
	else
		{
		//alert(paymentMode);
		
		jQuery.ajax({
			type:"POST",
			url:"fetchBalance.action?acctNumber="+acctNum+"&transactionMode="+paymentMode,
					success:function(data){
						

if(data.toUpperCase()==='ERROR')
	{
	jQuery('#acctBalanceLabel').text('The given account number does not exist');
	jQuery('#paymentProceed').hide();
	jQuery("#paymentNumber").prop('disabled', false);
	}
else
{

	var labelText="The balance in selected account number is:"+data+". ";
	
	
	if(parseFloat(data)>=parseFloat(jQuery('#acctBalHidden').val()))
	{
		jQuery('#paymentProceed').show();
		jQuery("#paymentNumber").prop('disabled', true);
	}
	else
		{
		labelText+="Insufficient Balance to make payment.";
		jQuery('#paymentProceed').hide();
		jQuery("#paymentNumber").prop('disabled', false);
		}
	jQuery('#acctBalanceLabel').text(labelText);
}
	
jQuery('#acctBalanceLabel').show();


						//alert("bal:"+jQuery('#acctBalHidden').val());
					}
			
		});
		
		
		
		}
}


function fetchBalance3()
{

	var paymentMode=jQuery('input:radio[name=transactionMode]:checked').val();
	var acctNum=jQuery('#paymentNumber').val();
	var tranAmountVal=jQuery('#acctBalHidden').val();
	
		jQuery.ajax({
			type:"POST",
			url:"fetchBalance.action?acctNumber="+acctNum+"&transactionMode="+paymentMode,
					success:function(data){
						

						
						//Start new
						
								  jQuery.getJSON(

				'performTransaction.action',
				
				/* If any parameters to action call it can be sent as below */ 
				 {
					'acctNumber':acctNum,
					'acctBal':data,
					'transactionMode':paymentMode,
					'transactionAmount':tranAmountVal
				
				}, 
					function(tranJsonResponse) {


					if(tranJsonResponse==undefined || tranJsonResponse=='')
					{
						//write code to redirect to error page
						
					}
					else {
						
						//This is the variable that we have put in jsonObject in actionclass
						var transactionDetails=tranJsonResponse.tranDetails;
					
						if(transactionDetails==undefined || transactionDetails=='')
						{
							//write code to redirect to error page
							
						}
						else
							{
							var tranObject=JSON.parse(transactionDetails);
							alert(tranObject.tranDesc);
							

							}


			}
						
		
			});
						
						//End new

	



						//alert("bal:"+jQuery('#acctBalHidden').val());
					}
			
		});
		
		
		
		
}








function fetchBalance2()
{

	var paymentMode=jQuery('input:radio[name=transactionMode]:checked').val();
	var acctNum=jQuery('#paymentNumber').val();
	if(acctNum.length==0)
	{
		alert("Enter a valid number");
		return false;
	}
	else
		return true;

}
$('document').ready(function(){  

	var $= jQuery.noConflict();
	/* $(".fancybox").fancybox({
        'autoScale': true,
        'transitionIn': 'elastic',
        'transitionOut': 'elastic',
        'speedIn': 500,
        'speedOut': 300,
        'autoDimensions': true,
        'centerOnScroll': true
    });
	 */
	
	

	
	$('input:radio[name=transactionMode]').on('change', function() {

		//alert($(this).val() );
	    
		switch($(this).val()) {
	         case '1':
	        	 document.getElementById('paymentNumber').placeholder="Enter Debit Card Number";
	             break;
	         case '2':
	        	 document.getElementById('paymentNumber').placeholder="Enter Credit Card Number";
	             break;
	         case '3':
	        	 document.getElementById('paymentNumber').placeholder="Enter Bank Account Number";
	             break;
	     }
	});
	
	
/* 	$("#searchBtn").click(function()
			{

	// Calling an action and getting response as json can be done using below call method 
		
		  $.getJSON(

				'listTutorials.action',
				
				 If any parameters to action call it can be sent as below  
				 {
					'phoneNumber':$("#phoneNumber").val()
				
				}, 
					function(tranJsonResponse) {


					if(tranJsonResponse==undefined || tranJsonResponse=='')
					{
						//write code to redirect to error page
						
					}
					else {
						
						//This is the variable that we have put in jsonObject in actionclass
						var transactionDetails=tranJsonResponse.tutorialsMasterList;
					
						if(transactionDetails==undefined || transactionDetails=='')
						{
							//write code to redirect to error page
							
						}
						else
							{
							
							//Form ui using datatable as below
							
							$("#tutorialsTable").show();
							$("#tutorialsTableHeading").html('Courses List');
							
							 These columns should be as same as in DTO 
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
					    	
					    	// Stuff the aaData array by iterating the transactionDetails from tranJsonResponse
					    	for (var i=0; i < transactionDetails.length; i++) {
					    	    var row = transactionDetails[i];
					    	    var dataTableRow = [];
					    	    for (var j=0; j < columns.length+1; j++) {
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
		  
		 window.location.href = "SignOutAction.action?"; 
	});	
						
		
			});
 */
	
	
	
    });




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
<label>Transaction Amount:</label>
<s:label id="tranAmount1" name="transactionAmount"></s:label>

<div id="paymentMode">
<input type="radio" name="transactionMode"  value="1" checked >Debt Card
<br><input type="radio" name="transactionMode"  value="2">Credit Card
<br><input type="radio" name="transactionMode"  value="3">Net Banking
<br><input type="text" name="acctNumber" id="paymentNumber" placeholder="Enter Debt Card Number" onkeypress="return isNumber(event)">
<label id="acctBalanceLabel" style="display:none;"></label>
<div id="paymentButtons">

<button onclick="fetchBalance1()" >Fetch Balance</button>

<button style="display:none;" id="paymentProceed" onclick="fetchBalance3()" >Make Payment</button>

</div>

<s:hidden id="acctBalHidden" name="transactionAmount"></s:hidden>

</div>

<%-- <input type="button" id="searchBtn" value="Search"></input>   
<div id="tutorialsTable" style="display:none;">
	<span id="tutorialsTableHeading" class="tableHeading"></span>
	<table id="tutorialListResults"	style="margin: 7px 5px 5px 2px" class="record"></table>
</div>
 --%>

<br>
<%-- <s:label>Name:</s:label><s:textfield value="Enter Text"></s:textfield>
 --%>
 </body>  
</html>



