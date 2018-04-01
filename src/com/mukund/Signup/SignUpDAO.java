package com.mukund.Signup;

public interface SignUpDAO {
public String logAudit(SignUpDTO dto,String result);
public String signUpUser(SignUpDTO signUpDTO);
public String checkUserNameAvailable(SignUpDTO signUpDTO);
}
