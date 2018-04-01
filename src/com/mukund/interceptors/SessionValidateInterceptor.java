package com.mukund.interceptors;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.json.JSONException;
import org.json.JSONObject;
import org.mukund.login.dao.LoginDAO;
import org.mukund.login.dao.TutorialsDAO;
import org.mukund.login.daoImpl.LoginDaoImpl;
import org.mukund.login.daoImpl.TutorialsDaoImpl;

import com.mukund.tutorials.dto.TutorialsDTO;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.interceptor.Interceptor;




public class SessionValidateInterceptor implements Interceptor{

	/*	ActionSupport class provides functionality to do validations on data and add 
	error messages if any validation fails

	Thus validate method is executed before execute method and if any error messages
	are added then it doesnt execute the execute method . instead the control flows back to the 
	action call with result as "input". i.e. to the page which calls this action
	 */

	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}
	@Override
	public void init() {
		// TODO Auto-generated method stub
		
	}
	@Override
	public String intercept(ActionInvocation ai) throws Exception {
		
		
		Map<String, Object> session = ActionContext.getContext().getSession();
		System.out.println("session user id:"+session.get("user_id"));
		System.out.println("session logged in flg:"+session.get("loggedInFlg"));
		String loggedInFlag=(String) session.get("loggedInFlg");
		
		if(session.get("user_id")!=null && loggedInFlag!=null && loggedInFlag.equalsIgnoreCase("true"))
			return ai.invoke();
		
		
		return "error";
	}

}
