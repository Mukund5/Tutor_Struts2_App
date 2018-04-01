package com.mukund.auditTrail;




public class AuditTrailAction{

	private AuditTrailDTO auditDTO;
	

	public AuditTrailDTO getAuditDTO() {
		return auditDTO;
	}

	public void setAuditDTO(AuditTrailDTO auditDTO) {
		this.auditDTO = auditDTO;
	}

	
	public String logAuditExecute(AuditTrailDTO dto)
	{

		AuditTrailDAO dao=new AuditTrailDaoImpl();
		
		
		String result=dao.logAudit(dto);
		
	
		return result;
		}
	}
