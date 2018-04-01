    <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title><tiles:insertAttribute name="title" ignore="true" />
</title>
<style type="text/css">
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
</head>
<body style="height:100%;width:99%">

<%-- <tiles:insertAttribute name="header" /><br/>
   <hr/>
   <tiles:insertAttribute name="menu" /><br/>
   <hr/>
   <tiles:insertAttribute name="body" /><br/>
   <hr/>
   <tiles:insertAttribute name="footer" /><br/> --%>
   
   	<div id="MainContainer" class="boxed-page" style="width:100%;height:100%">
		<table style="width:100%;height:600px"> 
		
			<tr >
				<td height="10%">
					<div>
						<tiles:insertAttribute name="header" />
					</div>
				<%-- 	<div>
						<tiles:insertAttribute name="menu" />
					</div> --%>
				</td>
			</tr>
			<tr >
				<td height="80%">
					<div id="ContentWrap">
						
							
							
									<%-- <tiles:insertAttribute name="breadCrumb"></tiles:insertAttribute> --%>
									<tiles:insertAttribute name="body" />
								</div>
					
				</td>
			</tr>
			<tr>
				<td height="10%">
					<div id="includeFooter">
						<tiles:insertAttribute name="footer" />
					</div>
				</td>
			</tr>
		</table>
	</div>
   
</body>
</html>