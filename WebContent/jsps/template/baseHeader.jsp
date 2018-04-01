	<%@ taglib prefix="s" uri="/struts-tags" %>
	<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Header</title>
</head>

<script type="text/javascript" src="../js/jquery-3.2.1.js"></script>
<%-- <script type="text/javascript" src="../js/jquery.fancybox.js"></script>


<link type="text/css" rel="stylesheet" href="../css/jquery.fancybox.css"/>
 --%>
<script type="text/javascript">

$(document).ready(function(){
	var $= jQuery.noConflict();
	//$.fancybox.init();
	//$(".fancybox").fancybox();
    $("#profileImg").click(function(){
        $("#profileDetails").slideToggle();
    });
    
    
});
</script>
<style>
.dropdown-content {
    display: none;
    position: absolute;
    background-color: #f9f9f9;
    min-width: 160px;
    overflow: auto;
    box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
    right: 0;
    z-index: 1;
}

.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}

</style>
<body>


    <div id="header">
        <!-- #header given to allow better targeting for CSS at a later stage  -->
        <div class="wrap">
            <!-- .wrap given  because multiple elements use the same wrap -->
            <div id="title-area">
                <h1 align="center" id="title">
                    <a href="#">My Tutor</a>
                    <!-- anchor tags are given href of # for demo purposes. -->
                </h1>
            <a>    <img alt="Profile" onmouseover="" src="../images/man2.png" width="4%" height="4%" align="right" style="padding-right: 5px;cursor: pointer;" id="profileImg"></a>
                <br>
                <br>
                <br>
<!--                 <table align="right" id="profileDetails" style="display:none;">
                <tr>
                <td>hi</td>
                </tr>
                <tr>
                <td>hello</td>
                </tr>
                
                </table>
 --> 
 
 <s:url action="SignOutAction.action" var="signOutTag" >
    <%-- <s:param name="name">mkyong</s:param> --%>
</s:url>

 <div id="profileDetails" class="dropdown-content">
    <a  href="#">View Profile</a>
    <a href="#">Settings</a>
    <a href='<s:property value="#urlTag" />'>Sign Out</a>
  </div>
            </div>

            
<!--                 <ul>
                An unordered list is used for navigation
                    <li><a href="#">Blog</a></li>
                    <li><a href="#">Portfolio</a></li>
                    <li><a href="#">Services</a></li>
                    <li><a href="#">About Me</a></li>
                    <li><a href="#">Contact </a></li>
                </ul>
 -->            
        </div>
    </div>



</body>
</html>