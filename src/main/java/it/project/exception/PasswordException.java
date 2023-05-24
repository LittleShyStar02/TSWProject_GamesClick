package it.project.exception;

import java.io.IOException;

public class PasswordException extends IOException
{

	private static final long serialVersionUID = 1L;
	private String message;
	
	public PasswordException() {
		message = "Le password inserite non sono uguali";
	}
	
	public String getMessage()
	{
		return message;
	}

}
