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
<link type="text/css" rel="stylesheet" href="../css/datatable.min.css"/>
<link type="text/css" rel="stylesheet" href="../css/jquery.fancybox.css"/>

<script type="text/javascript" src="../js/jquery-3.2.1.js"></script>
<script type="text/javascript" src="../js/datatable.min.js"></script>
<%-- <script type="text/javascript" src="../js/dataTables.jqueryui.js"></script> --%>
<script type="text/javascript" src="../js/jquery.fancybox.js"></script>

<script type="text/javascript" src="../js/xlsx.core.min.js"></script>
<script type="text/javascript" src="../js/excelplus-2.5.min.js"></script>
<script type="text/javascript" src="../js/jspdf.min.js"></script>
<script type="text/javascript" src="../js/jspdf.plugin.autotable.js"></script>


<style>

td.highlight {
    background-color: black !important;
}
</style>


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
		
							//alert(tutorialsList);

							//$('#tutorialListResults').DataTable().data(tutorialsList);
							
							 $('#tutorialListResults').DataTable( {
								select: true,
								data: tutorialsList,
						        columns: [
						            { data:"courseName",title: "Course Name" },
						            { data:"courseDuration", title: "Course Duration" },
						            { data:"courseFee", title: "Course Fee" },
						            { data:"tutorName", title: "Tutor Name" },
						            { data:"courseDomain", title: "Course Domain" },
						            {data:null,title:"Payment", defaultContent:"<a onclick='makePayment()'>Payment</a>"}
						            ]
						            
						    } ); 
	
							}


			}
						
		
			});

	
	
	
    });

	
	
	
});

/* $('#tutorialListResults tbody').click(function () {
	 alert("a");
       var data = $('#tutorialListResults').DataTable().row( $(this).parents('tr') ).data();
       alert( data[0] +"'s salary is: "+ data[ 3 ] );
   } ); */

   function exportExcel()
   {
	   
	   var ep=new ExcelPlus();
	   var excelFile=ep.createFile("Tutorials");
	   var counter=1;
	   
	   
	   excelFile.writeRow(1,['S.No','Course Name','Course Duration','Course Fee','Tutor Name','Course Domain']);
	   
	   
	   var table=jQuery('#tutorialListResults tbody');
	   table.find('tr').each(function(i,el)
			   {
		   var tds=jQuery(this).find('td'),
		   courseName=tds.eq(0).text(),
		   duration=tds.eq(1).text(),
		   fee=tds.eq(2).text(),
		   tutor=tds.eq(3).text(),
		   domain=tds.eq(4).text();
		   
		counter++;
		
		excelFile.writeRow(counter,[counter-1,courseName,duration,fee,tutor,domain]);
		
			   }
			   
	   
	   
	   )
	   
	   var d=new Date();
	   var n=d.getTime();
	   
	   excelFile.saveAs("Tutorials_"+n+".xlsx");
   }
   

   
   function exportPDF()
   {
	   
	   var heading="Tutorials";
	   
	   var columns=['S.No','Course Name','Course Duration','Course Fee','Tutor Name','Course Domain'];
	   
	   var rows=[];
	   
	   var counter=1;
	   
	   
	   
	   var table=jQuery('#tutorialListResults tbody');
	   
	   table.find('tr').each(function(i,el)
			   {
		   var tds=jQuery(this).find('td'),
		   courseName=tds.eq(0).text(),
		   duration=tds.eq(1).text(),
		   fee=tds.eq(2).text(),
		   tutor=tds.eq(3).text(),
		   domain=tds.eq(4).text();
		   
		counter++;
		
		rows.push([counter-1,courseName,duration,fee,tutor,domain]);
		
			   }
			   
	   
	   
	   );
	   
	   var doc=new jsPDF('p','pt','a4');
	   doc.setFont("courier");
	   doc.setTextColor(250,0,0);
	   doc.setFontSize(20);
	   doc.page=1;
	   doc.setFontStyle("bold");
	   doc.text(250,50,heading);


	   doc.setFontSize(20);
	   doc.text(50,50,"    ");
	   
	   doc.autoTable(columns,rows,{
		styles:{
			columnWidth:'wrap',
			rowHeight:'100'
		},
		theme:'grid',
		margin:{
			top:60
		},
		tableWidth:'auto',
		styles:{
			overflow:'linebreak',
			valign:'middle',
			halign:'middle'
		},
		   headerStyles:{
			   
			   lineWidth:0,
			   fontStyle:'bold',
			   halign:'center',
			   fillColor:[52,152,219],
			   textColor:[255,255,255],
			   fontSize:10,
			   columnWidth:'auto',
			   rowHeight:30
			   
		   },
		   
		   bodyStyles:{
			   
			   lineWidth:0.9,
			   textColor:[78,53,73]
			   
		   }
		   
	   });
	   //doc.text(20,doc.autoTableEndPosY,"~~~ End Of Document ~~~");
	   
	   var d=new Date();
	   var n=d.getTime();
	   
	   doc.save("Tutorials_"+n+".pdf");
   }
   

   
   
   function makePayment()
    {
    	alert("hiii");

    	var table=jQuery('#tutorialListResults').DataTable();
    	  var data = table.rows(2).data();
    	  alert(data);
          alert( data[0] +"'s salary is: "+ data[ 3 ] );
          
         /* var data = table.row( $(this).parents('tr') ).data();
        alert( data[0] +"'s salary is: "+ data[ 3 ] ); */ 
   	  //var oTable = $('#tutorialListResults').dataTable();
	 
 
    	
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


<table id="example" class="display" width="100%"></table>


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

<br>
<br>
<input type="button" id="searchBtn" value="Search"></input>   
<div id="tutorialsTable" style="display:none;">
<button onclick="exportExcel()">Export as Excel</button>
<button onclick="exportPDF()">Export as PDF</button>
<br>
	<span id="tutorialsTableHeading" class="tableHeading"></span>
	<table id="tutorialListResults"	style="margin: 7px 5px 5px 2px" class="record"></table>
	
	<br>
	
<s:url namespace="/" action="proceedToPayment" var="makePaymentLink">
 	<s:param name="transactionAmount" value="13566"></s:param> 
</s:url>

<a href='<s:property value="#makePaymentLink"/>'>Proceed to Payment</a>

<%-- <s:url namespace="/" action="proceedToPayment" var="makePaymentLink">
 	<s:param name="transactionAmount">135617</s:param> 
</s:url>

<a href='<s:property value="#makePaymentLink"/>'>Proceed to Payment</a>

<s:url namespace="/" action="proceedToPayment" var="makePaymentLink">
<s:set name="myTestVar" value="54"></s:set>
 	<s:param name="transactionAmount" value="myTestVar"></s:param> 
</s:url>

<a href='<s:property value="#makePaymentLink"/>'>Proceed to Payment</a>
 --%>
 
 	
</div>

<br>



<%-- <s:label>Name:</s:label><s:textfield value="Enter Text"></s:textfield>
 --%>
 </body>  
</html>



