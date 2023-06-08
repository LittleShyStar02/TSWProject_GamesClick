package it.project.exception;

import java.io.IOException;

public class AdminExists extends IOException
{

	private static final long serialVersionUID = 1L;
	private final String message;
	
	public AdminExists() {
		message = "L'utente è già un amministratore";
	}
	
	@Override
	public String getMessage()
	{
		return message;
	}

}
