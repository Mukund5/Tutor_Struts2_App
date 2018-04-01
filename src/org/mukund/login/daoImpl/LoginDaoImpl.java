package org.mukund.login.daoImpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.mukund.login.dao.LoginDAO;

public class LoginDaoImpl implements LoginDAO{

	@Override
	public String loginValidate(String userId, String password) {
		Connection postgresConn=getPostgresConnection();
		
		String statement="select count(1) from logincredentials where userId='"+userId+"' and password='"+password+"'";
		
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		try {
			pstmt=postgresConn.prepareStatement(statement);
			
			rs=pstmt.executeQuery();
			
			if(rs.next())
			{
				int count=rs.getInt(1);
				if(count>=1)
					return "success";
			}
			
			
			
			return "error";
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
				
		finally
		{
			try {
				if(null!=pstmt)
				pstmt.close();
				if(null!=rs)
					rs.close();
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
