package org.mukund.login.action;

import java.util.Map;

import org.apache.struts2.dispatcher.SessionMap;
import org.apache.struts2.interceptor.SessionAware;
import org.mukund.login.dao.LoginDAO;
import org.mukund.login.daoImpl.LoginDaoImpl;

import com.mukund.auditTrail.AuditTrailAction;
import com.mukund.auditTrail.AuditTrailDTO;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;



//action is added for returning proper results like SUCCESS
public class SignOutAction implements Action{

	
	SessionMap<String, String> sessionMap;
	
	
	@Override
	public String execute() throws Exception {
		Map<String, Object> session = ActionContext.getContext().getSession();
		session.remove("user_id");
		System.out.println("bbb");
		//Removing session
		//sessionMap.invalidate();
		//Start for audit
		AuditTrailDTO dto=new AuditTrailDTO(); 
		dto.setActionPerformed("Signout from Mytutor Application");
		dto.setActionResult("Successfully logged out from application");
		AuditTrailAction audit=new AuditTrailAction();
		audit.logAuditExecute(dto);
		//End for audit
		return SUCCESS;
	
	}

	
		
}
