package org.mukund.test.action;
import org.mukund.test.service.*;

public class BusinessServiceUIAction {
	
	private String resultUniversity;
	
	public String getResultUniversity() {
		return resultUniversity;
	}


	public void setResultUniversity(String resultUniversity) {
		this.resultUniversity = resultUniversity;
	}	
public String execute(){
	System.out.println("Inside execute of UI");
	TestBusinessService t=new TestBusinessService();
	this.setResultUniversity(t.getTutorialUI());
	System.out.println("result returned:"+this.getResultUniversity());
	return "failure";
}



}
