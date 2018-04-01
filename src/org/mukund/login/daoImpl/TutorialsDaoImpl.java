package org.mukund.login.daoImpl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.mukund.login.dao.LoginDAO;
import org.mukund.login.dao.TutorialsDAO;

import com.mukund.tutorials.dto.TutorialsDTO;

public class TutorialsDaoImpl implements TutorialsDAO{

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
	public ArrayList<TutorialsDTO> listTutorials() {

		Connection postgresConn=getPostgresConnection();
		
		
		String statement="select courseName,courseDuration,courseFee,tutorName,courseDomain from tutorials";
		
		try {
			PreparedStatement pstmt=postgresConn.prepareStatement(statement);
			
			ResultSet rs=pstmt.executeQuery();
			ArrayList<TutorialsDTO> tutorials=new ArrayList<TutorialsDTO>();
			System.out.println("entering");
			while(rs.next())
			{
				TutorialsDTO t=new TutorialsDTO(); 
				System.out.println("name:"+rs.getString("courseName"));
				t.setCourseName(rs.getString("courseName"));
				t.setCourseDuration(rs.getString("courseDuration"));
				t.setCourseFee(rs.getInt("courseFee"));
				t.setTutorName(rs.getString("tutorName"));
				t.setCourseDomain(rs.getString("courseDomain"));
					tutorials.add(t);
			}
			
			
			
			return tutorials;
		} catch (SQLException e) {
			
			e.printStackTrace();
		}
				
				
				
		
		return null;
	
	}
}
