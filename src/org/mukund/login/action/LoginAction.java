package org.mukund.login.action;

import java.util.Map;

import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;
import org.mukund.login.dao.LoginDAO;
import org.mukund.login.daoImpl.LoginDaoImpl;

import com.mukund.auditTrail.AuditTrailAction;
import com.mukund.auditTrail.AuditTrailDTO;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionInvocation;



//SessionAware is added for session validation and action is added for returning proper results like SUCCESS
public class LoginAction implements SessionAware{

	private String loginUserId;
	private String loginPassword;

	SessionMap<String, String> sessionMap;
	
	public String getLoginUserId() {
		return loginUserId;
	}
	public void setLoginUserId(String loginUserId) {
		this.loginUserId = loginUserId;
	}
	public String getLoginPassword() {
		return loginPassword;
	}
	public void setLoginPassword(String loginPassword) {
		this.loginPassword = loginPassword;
	}
	
	
	
	public String signIn()
	{

		System.out.println("dao");
			LoginDAO dao=new LoginDaoImpl();
			String result=dao.loginValidate(loginUserId, loginPassword);
			System.out.println("bla:"+getLoginUserId());
			sessionMap.put("user_id", getLoginUserId());
			
		/*if(loginUserId.equalsIgnoreCase("Mukund") && loginPassword.equalsIgnoreCase("munna123!"))	
			return SUCCESS;
		return ERROR;*/
			
			//Start for audit
			AuditTrailDTO dto=new AuditTrailDTO(); 
			dto.setActionPerformed("Login to Mytutor Application");
			
			if(result.equalsIgnoreCase("SUCCESS"))
			dto.setActionResult("Successfully logged in");
			else
				dto.setActionResult("Login Failure");
			
			AuditTrailAction audit=new AuditTrailAction();
			
			audit.logAuditExecute(dto);
			//End for audit
			
			
			return result;
		
	}
	public String signOut()
	{
		//Removing session
		sessionMap.invalidate();
		//Start for audit
		AuditTrailDTO dto=new AuditTrailDTO(); 
		dto.setActionPerformed("Signout from Mytutor Application");
		dto.setActionResult("Successfully logged out from application");
		AuditTrailAction audit=new AuditTrailAction();
		audit.logAuditExecute(dto);
		//End for audit
		return "success";
	}
	@Override
	public void setSession(Map<String, Object> map) {

		//Here we cant access variables directly using name. 
		//We need to access from value stack. ie where struts stores in memory
		sessionMap=(SessionMap)map;
		
        sessionMap.put("loggedInFlg", "true");
        
	}
	
}
