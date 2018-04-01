package org.mukund.test.action;
import org.mukund.test.service.*;

public class BusinessServiceAction {
public String execute(){
	System.out.println("Inside execute");
	TestBusinessService t=new TestBusinessService();
	System.out.println("result returned:"+t.getTutorial());
	return "failure";
}
}
