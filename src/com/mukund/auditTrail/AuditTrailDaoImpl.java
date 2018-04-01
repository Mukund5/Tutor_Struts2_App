package com.mukund.auditTrail;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
//import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Map;

import com.opensymphony.xwork2.ActionContext;


public class AuditTrailDaoImpl implements AuditTrailDAO{

	@Override
	public String logAudit(AuditTrailDTO auditDTO) {
		Connection postgresConn=getPostgresConnection();
		
		Map<String, Object> session = ActionContext.getContext().getSession();
		//System.out.println("session user id:"+session.get("user_id"));
		
		//Getting current time stamp
		java.util.Date today = new java.util.Date();
		java.sql.Timestamp currTime=new java.sql.Timestamp(today.getTime());
		
		String insertStatement="insert into audit_trail (user_id,action_performed,action_result,time_of_action) values(?,?,?,?)";
		
		PreparedStatement pstmt=null;
		//ResultSet rs=null;
		try {
			pstmt=postgresConn.prepareStatement(insertStatement);
			
			pstmt.setString(1, (String)session.get("user_id"));
			pstmt.setString(2, auditDTO.getActionPerformed());
			pstmt.setString(3, auditDTO.getActionResult());
			pstmt.setTimestamp(4, currTime);
			
			int updatedCount=pstmt.executeUpdate();
			
			if(updatedCount==1)
			{
				
					return "success";
			}
			
			else
						return "error";
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
		finally
		{
			try {
				if(null!=pstmt)
				pstmt.close();
			//	rs.close();
				if(null!=postgresConn)
				postgresConn.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			
		}
				
				
		
		return null;
	}

	public Connection getPostgresConnection()
	{
		Connection pgConn=null;
		
		try {
			Class.forName("org.postgresql.Driver");
			pgConn=DriverManager.getConnection("jdbc:postgresql://localhost:5432/postgres", "postgres", "postgres");
		} catch (SQLException e) {
			
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			
			e.printStackTrace();
		}
		
		return pgConn;
	}
}
