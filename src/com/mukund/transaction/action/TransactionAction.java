package com.mukund.transaction.action;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.json.JSONException;
import org.json.JSONObject;
import org.mukund.login.dao.TutorialsDAO;
import org.mukund.login.daoImpl.TutorialsDaoImpl;

import com.mukund.auditTrail.AuditTrailAction;
import com.mukund.auditTrail.AuditTrailDTO;
import com.mukund.transaction.service.TransactionService;
import com.mukund.tutorials.dto.Transaction;
import com.mukund.tutorials.dto.TutorialsDTO;



public class TransactionAction {

	private String acctNumber;
	private String acctBal;
	private InputStream acctBalance;
	private String transactionMode;
	private String transactionAmount;
	private String processFee;
	private org.json.JSONObject tranDetails;
	
	public String getAcctNumber() {
		return acctNumber;
	}
	public void setAcctNumber(String acctNumber) {
		this.acctNumber = acctNumber;
	}
	public String getAcctBal() {
		return acctBal;
	}
	public void setAcctBal(String acctBal) {
		this.acctBal = acctBal;
	}
	public InputStream getAcctBalance() {
		return acctBalance;
	}
	public void setAcctBalance(InputStream acctBalance) {
		this.acctBalance = acctBalance;
	}
	public String getTransactionMode() {
		return transactionMode;
	}
	public void setTransactionMode(String transactionMode) {
		this.transactionMode = transactionMode;
	}
	public String getTransactionAmount() {
		return transactionAmount;
	}
	public void setTransactionAmount(String transactionAmount) {
		this.transactionAmount = transactionAmount;
	}
	
	public String getProcessFee() {
		return processFee;
	}
	public void setProcessFee(String processFee) {
		this.processFee = processFee;
	}
	public org.json.JSONObject getTranDetails() {
		return tranDetails;
	}
	public void setTranDetails(org.json.JSONObject tranDetails) {
		this.tranDetails = tranDetails;
	}
	public String execute()
	{
		System.out.println("amt:"+getTransactionAmount());
		return "success";
	}
	
	public String fetchBalance()
	{
		System.out.println("in here");
		TransactionService tSer=new TransactionService();
		//setAcctBal(tSer.fetchBalance(getAcctNumber(),getTransactionMode()));
		String returnedBalance=tSer.fetchBalance(getAcctNumber(),getTransactionMode());
		try {
			setAcctBalance(new ByteArrayInputStream(returnedBalance.getBytes("UTF-8")));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		
		
		return "success";
	}

	public JSONObject performTran()
	{
		System.out.println("in tran");
		TransactionService tSer=new TransactionService();
		//setAcctBal(tSer.fetchBalance(getAcctNumber(),getTransactionMode()));
		String returnedProcFee=tSer.getProcessFee(getAcctNumber(),getTransactionMode(),getTransactionAmount());
		
		setProcessFee(returnedProcFee);
		
		String tran=tSer.performTransaction(getAcctNumber(), getAcctBal(), getTransactionMode(), getTransactionAmount(), getProcessFee());
		
		//start
		
			/*To return jsonobject as response from action we need to write it to 
			 * httpservlet response as below*/

			tranDetails=new JSONObject();
			try {
				tranDetails.put("tranDetails", tran);
				//tranDetails.toString();
				//System.out.println("jspn resp:"+tranDetails.toString());
				//JSONObject.quote(tranDetails.toString());
				//logger.info(jsonObject); 
				HttpServletResponse response = ServletActionContext.getResponse();
				PrintWriter printWriter = response.getWriter();
				printWriter.println(tranDetails);

			} catch (JSONException e) {

/*				AuditTrailDTO dto=new AuditTrailDTO(); 
				dto.setActionPerformed("List tutorials");
				dto.setActionResult("Failure in listing tutorials");
				AuditTrailAction audit=new AuditTrailAction();
				audit.logAuditExecute(dto);
*/
				e.printStackTrace();
				
			} catch (IOException e) {
/*				AuditTrailDTO dto=new AuditTrailDTO(); 
				dto.setActionPerformed("List tutorials");
				dto.setActionResult("Failure in listing tutorials");
				AuditTrailAction audit=new AuditTrailAction();
				audit.logAuditExecute(dto);
*/
				e.printStackTrace();
			}


		
		//end
		
		return null;
	}

	
	
}
