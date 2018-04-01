package org.mukund.login.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.json.JSONException;
import org.json.JSONObject;
import org.mukund.login.dao.LoginDAO;
import org.mukund.login.dao.TutorialsDAO;
import org.mukund.login.daoImpl.LoginDaoImpl;
import org.mukund.login.daoImpl.TutorialsDaoImpl;

import com.mukund.auditTrail.AuditTrailAction;
import com.mukund.auditTrail.AuditTrailDTO;
import com.mukund.tutorials.dto.TutorialsDTO;
import com.opensymphony.xwork2.Action;
import com.opensymphony.xwork2.ActionSupport;




public class ListTutorialAction extends ActionSupport{

	/*	ActionSupport class provides functionality to do validations on data and add 
	error messages if any validation fails

	Thus validate method is executed before execute method and if any error messages
	are added then it doesnt execute the execute method . instead the control flows back to the 
	action call with result as "input". i.e. to the page which calls this action
	 */
	private String loginUserId;
	private String loginPassword;

	private org.json.JSONObject jsonObject;

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

	public org.json.JSONObject getJsonObject() {
		return jsonObject;
	}
	public void setJsonObject(org.json.JSONObject jsonObject) {
		this.jsonObject = jsonObject;
	}
	public void validate()
	{}
	@Override
	public String execute() throws Exception {

		LoginDAO dao=new LoginDaoImpl();
		String result=dao.loginValidate(loginUserId, loginPassword);

		/*if(loginUserId.equalsIgnoreCase("Mukund") && loginPassword.equalsIgnoreCase("munna123!"))	
		return SUCCESS;
	return ERROR;*/
		return result;
	}

	public JSONObject listTutorials() 
	{
		System.out.println("start");
		TutorialsDAO dao=new TutorialsDaoImpl();
		java.util.ArrayList<TutorialsDTO> tutorialList=dao.listTutorials();

		/*To return jsonobject as response from action we need to write it to 
		 * httpservlet response as below*/

		jsonObject=new JSONObject();
		try {
			jsonObject.put("tutorialsMasterList", tutorialList);
			jsonObject.toString();
			System.out.println("jspn resp:"+jsonObject.toString());
			JSONObject.quote(jsonObject.toString());
			//logger.info(jsonObject); 
			HttpServletResponse response = ServletActionContext.getResponse();
			PrintWriter printWriter = response.getWriter();
			printWriter.println(jsonObject);

			//Start for audit
			AuditTrailDTO dto=new AuditTrailDTO(); 
			dto.setActionPerformed("List tutorials");
			dto.setActionResult("Successfully Listed tutorials");
			AuditTrailAction audit=new AuditTrailAction();
			audit.logAuditExecute(dto);
			//End for audit
		} catch (JSONException e) {

			AuditTrailDTO dto=new AuditTrailDTO(); 
			dto.setActionPerformed("List tutorials");
			dto.setActionResult("Failure in listing tutorials");
			AuditTrailAction audit=new AuditTrailAction();
			audit.logAuditExecute(dto);

			e.printStackTrace();
			
		} catch (IOException e) {
			AuditTrailDTO dto=new AuditTrailDTO(); 
			dto.setActionPerformed("List tutorials");
			dto.setActionResult("Failure in listing tutorials");
			AuditTrailAction audit=new AuditTrailAction();
			audit.logAuditExecute(dto);

			e.printStackTrace();
		}

		return null;
	}

}
