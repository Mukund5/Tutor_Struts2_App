package com.mukund.Signup;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.json.JSONException;
import org.json.JSONObject;
import org.mukund.login.dao.TutorialsDAO;
import org.mukund.login.daoImpl.TutorialsDaoImpl;

import com.mukund.auditTrail.AuditTrailAction;
import com.mukund.auditTrail.AuditTrailDTO;
import com.mukund.tutorials.dto.TutorialsDTO;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;


public class SignUpAction extends ActionSupport implements Action{

	private SignUpDTO signUpDTO;
	private List<String> userCategories;
	

	public SignUpAction() {
		signUpDTO =new SignUpDTO();
		userCategories = new ArrayList<String>();
		userCategories.add("Tutor");
		userCategories.add("Learner");
	}

	public SignUpDTO getSignUpDTO() {
		return signUpDTO;
	}

	public void setSignUpDTO(SignUpDTO signUpDTO) {
		this.signUpDTO = signUpDTO;
	}
	public List<String> getUserCategories() {
		return userCategories;
	}

	public void setUserCategories(List<String> userCategories) {
		this.userCategories = userCategories;
	}
	
@Override
public String execute()
{
	return "success";
}
	public String signUp()
	{
		
		System.out.println("in signup");
		
		SignUpDAO dao=new SignUpDaoImpl();
		

		String result1=dao.signUpUser(this.signUpDTO);
		
		String result2=dao.logAudit(this.signUpDTO,result1);
		
	
		return result2;

	}
public String chkUsrName()
{
	//new start
	

	System.out.println("in checking");
	
	SignUpDAO dao=new SignUpDaoImpl();
	

	String result1=dao.checkUserNameAvailable(this.signUpDTO);
System.out.println("got:"+result1);
	HttpServletResponse response=ServletActionContext.getResponse();
	try {
		PrintWriter printWriter=response.getWriter();
		
		printWriter.println(result1);
		
	} catch (IOException e) {

		e.printStackTrace();
	}

	return null;

	//new end
	
	
	}
}