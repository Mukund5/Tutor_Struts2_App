package com.mukund.Signup;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
//import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.mukund.tutorials.dto.TutorialsDTO;
import com.opensymphony.xwork2.ActionContext;


public class SignUpDaoImpl implements SignUpDAO{

	@Override
	public String logAudit(SignUpDTO dto,String result) {
		Connection postgresConn=getPostgresConnection();
		
		
		//Getting current time stamp
		java.util.Date today = new java.util.Date();
		java.sql.Timestamp currTime=new java.sql.Timestamp(today.getTime());
		
		String insertStatement="insert into audit_trail (user_id,action_performed,action_result,time_of_action) values(?,?,?,?)";
		
		PreparedStatement pstmt=null;
		//ResultSet rs=null;
		try {
			pstmt=postgresConn.prepareStatement(insertStatement);
			
			pstmt.setString(1, "New User");
			pstmt.setString(2, "User Tried to signup with userid "+dto.getUserId() );
			if(result.equalsIgnoreCase("success"))
			pstmt.setString(3, "Successfully signed up");
			else
				pstmt.setString(3, "Failure in signing up");
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

	@Override
	public String signUpUser(SignUpDTO signUpDTO) {
		Connection postgresConn=getPostgresConnection();

		//Insert into userdetails table start
		
		//Getting current time stamp
		java.util.Date today = new java.util.Date();
		java.sql.Timestamp currTime=new java.sql.Timestamp(today.getTime());
		
		
		String d=signUpDTO.getDob().substring(0, 10);
		String insertStatement="insert into userDetails (userId ,userCategory ,dateOfBirth,address,education  ,mobileNumber,gender,createdtimestamp,delflg)"
				+ " values(?,?,TO_DATE(?,'mm/dd/yyyy'),?,?,?,?,?,?)";
		
		PreparedStatement pstmt=null;
		PreparedStatement pstmt1=null;
		//ResultSet rs=null;
		try {
			pstmt=postgresConn.prepareStatement(insertStatement);
			
			pstmt.setString(1, signUpDTO.getUserId());
			pstmt.setString(2, signUpDTO.getUserCategory());
			
			System.out.println("date val:"+signUpDTO.getDob());
			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date date = (java.util.Date) formatter.parse(d);
			
			SimpleDateFormat formatter1 = new SimpleDateFormat("MM/dd/yyyy");
			String finalFormat=formatter1.format(date);
			System.out.println("done:"+date);
			System.out.println("done1:"+finalFormat);
			//pstmt.setString(3, "CAST ('"+signUpDTO.getDob()+"' as DATE)");
			pstmt.setString(3, finalFormat);
			pstmt.setString(4, signUpDTO.getAddress());
			pstmt.setString(5, signUpDTO.getEducation());
			pstmt.setString(6, signUpDTO.getMobileNumber());
			pstmt.setString(7, signUpDTO.getGender());
			pstmt.setTimestamp(8, currTime);
			pstmt.setBoolean(9, false);
			int updatedCount=pstmt.executeUpdate();
			
			//Insert into userdetails table end			
			
			//Insert into logincredentials table start

			String insertStatement1="insert into logincredentials (userid,password,createdtimestamp,delflg) "
					+ " values(?,?,?,?)";
			
				pstmt1=postgresConn.prepareStatement(insertStatement1);
				
				pstmt1.setString(1, signUpDTO.getUserId());
				pstmt1.setString(2, signUpDTO.getPassword());
				
				currTime=new java.sql.Timestamp(today.getTime());
				pstmt1.setTimestamp(3, currTime);
				pstmt1.setBoolean(4, false);
				int updatedCount1=pstmt1.executeUpdate();

			
			//Insert into logincredentials table end
			
			if(updatedCount==1 && updatedCount1==1)
			{
				
					return "success";
			}
			
			else
						return "error";
		} catch (SQLException e) {
			
			e.printStackTrace();
		} /*catch (ParseException e) {

			e.printStackTrace();
		}*/ catch (ParseException e) {

			e.printStackTrace();
		}
		finally
		{
			try {
				if(null!=pstmt)
				pstmt.close();
				if(null!=pstmt1)
					pstmt.close();
			//	rs.close();
				if(null!=postgresConn)
				postgresConn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			
			
		}
	
		return null;
	}
	
	@Override
	public String checkUserNameAvailable(SignUpDTO dto) {

		Connection postgresConn=getPostgresConnection();
		
		String res="";
		String statement="select count(1) from logincredentials where upper(userid) ='"+dto.getUserId().toUpperCase()+"'";
		
		try {
			PreparedStatement pstmt=postgresConn.prepareStatement(statement);
			
			ResultSet rs=pstmt.executeQuery();
			int userCount=0;
			System.out.println("entering result");
			while(rs.next())
			{
				 
				userCount=Integer.parseInt(rs.getString(1));
				
			}
			
			
			
			
				if(userCount==0)
				res="success";
				else
					res="failure";
			
			
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
				
				
				
		
		return res;
	
	}
}
