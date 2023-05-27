package it.project.exception;

import java.io.IOException;

public class AdminExists extends IOException
{

	private static final long serialVersionUID = 1L;
	private String message;
	
	public AdminExists() {
		message = "L'utente è già un amministratore";
	}
	
	public String getMessage()
	{
		return message;
	}

}
