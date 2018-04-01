package com.mukund.auditTrail;

public class AuditTrailDTO {
private String userId;
private String actionPerformed;
private String actionResult;
private String actionTime;
public String getUserId() {
	return userId;
}
public void setUserId(String userId) {
	this.userId = userId;
}
public String getActionPerformed() {
	return actionPerformed;
}
public void setActionPerformed(String actionPerformed) {
	this.actionPerformed = actionPerformed;
}
public String getActionResult() {
	return actionResult;
}
public void setActionResult(String actionResult) {
	this.actionResult = actionResult;
}
public String getActionTime() {
	return actionTime;
}
public void setActionTime(String actionTime) {
	this.actionTime = actionTime;
}


}
