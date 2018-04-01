package com.mukund.transaction.service;


import java.io.IOException;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.Invocation;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mukund.tutorials.dto.Account;
import com.mukund.tutorials.dto.Transaction;

public class TransactionService {

	private final String restMainUri="http://localhost:8080/PaymentGateway_RestService/mypaymentService";
	
	public String fetchBalance(String accountNum,String tranMode)
	{

		
		Client client=ClientBuilder.newClient();
		//Response res=client.target(restMainUri).path("accounts").path("balance").path("3").path("486556492").request(MediaType.APPLICATION_JSON).get();
		Response res=client.target(restMainUri).path("accounts").path("balance").path(tranMode).path(accountNum).request(MediaType.APPLICATION_JSON).get();

		Account x=res.readEntity(Account.class);
		//System.out.println(client.target(restMainUri).path("accounts").path("balance").path("3").path("486556492").request(MediaType.APPLICATION_JSON).get());
		//System.out.println(x.getAccountBalance());
		
		
		
		if(null!=x)
		{
			Long acctBal=x.getAccountBalance();
			return acctBal.toString();
		}
		else 
			return "Error";
		//System.out.println(x.getAccountNumber());

	}
	
	
	public String getProcessFee(String accountNum,String tranMode,String tranAmt)
	{

		
		Client client=ClientBuilder.newClient();
		//Response res=client.target(restMainUri).path("accounts").path("balance").path("3").path("486556492").request(MediaType.APPLICATION_JSON).get();
		//http://localhost:8080/PaymentGateway_RestService/mypaymentService/accounts/486556492/transaction/processingFee/3/1500
		Response res=client.target(restMainUri).path("accounts").path(accountNum).path("transaction").path("processingFee").path(tranMode).path(tranAmt).request(MediaType.TEXT_PLAIN).get();

		String procFee=res.readEntity(String.class);
		//System.out.println(client.target(restMainUri).path("accounts").path("balance").path("3").path("486556492").request(MediaType.APPLICATION_JSON).get());
		//System.out.println(x.getAccountBalance());
		
		
		return procFee;
	}

	public String performTransaction(String accountNum,String acctBal,String tranMode,String tranAmt,String procFee)
	{

		
		Client client=ClientBuilder.newClient();

		


/*		Ex: http://localhost:8080/PaymentGateway_RestService/mypaymentService/transaction/3/payment/945/1
			{
			"accountNumber":486556492
			}
*/
		Account newAcc=new Account(Long.valueOf(accountNum), Long.valueOf(acctBal));
		Response res=client.target(restMainUri).path("transaction").path(tranMode).path("payment").path(tranAmt).path(procFee).request(MediaType.APPLICATION_JSON).put(Entity.entity(newAcc, MediaType.APPLICATION_JSON));		
		
		
		String x1=res.readEntity(String.class);

		System.out.println("Tran:"+x1);



		//create ObjectMapper instance
		ObjectMapper objectMapper = new ObjectMapper();
		Transaction t1= new Transaction();
		//convert json string to object
		try {
			t1= objectMapper.readValue(x1, Transaction.class);
			System.out.println("t1:"+t1.getBankAccountNumber());
			System.out.println("t2:"+t1.getPaymentAmount());
			System.out.println("t3:"+t1.getTransactionTime());
		} catch (IOException e) {

			e.printStackTrace();
		}
	

		
		
		
		//System.out.println(client.target(restMainUri).path("accounts").path("balance").path("3").path("486556492").request(MediaType.APPLICATION_JSON).get());
		//System.out.println(x.getAccountBalance());
		
		
		return x1;
	}

/*
		Client client1=ClientBuilder.newClient();
		Response res1=client1.target(restMainUri).path("accounts").path("5494070242766165").path("transaction").path("processingFee").path("2").path("1500").request(MediaType.TEXT_PLAIN).get();

		String processFee=res1.readEntity(String.class);
		//System.out.println(client.target(restMainUri).path("accounts").path("balance").path("3").path("486556492").request(MediaType.APPLICATION_JSON).get());
		System.out.println(processFee);


		Account newAcc=new Account(x.getAccountNumber(), x.getAccountBalance());
		Client client2=ClientBuilder.newClient();
		Response res2=client2.target(restMainUri).path("transaction").path("3").path("payment").path("500").path("5").request(MediaType.APPLICATION_JSON).put(Entity.entity(newAcc, MediaType.APPLICATION_JSON));
		String x1=res2.readEntity(String.class);

		System.out.println("Tran:"+x1);



		//create ObjectMapper instance
		ObjectMapper objectMapper = new ObjectMapper();

		//convert json string to object
		try {
			Transaction t1= objectMapper.readValue(x1, Transaction.class);
			System.out.println("t1:"+t1.getBankAccountNumber());
			System.out.println("t2:"+t1.getPaymentAmount());
			System.out.println("t3:"+t1.getTransactionTime());
		} catch (IOException e) {

			e.printStackTrace();
		}
	}
*/
}
