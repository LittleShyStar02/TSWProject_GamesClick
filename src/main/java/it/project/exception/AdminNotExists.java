package it.project.exception;

import java.io.IOException;

public class AdminNotExists extends IOException
{

	private static final long serialVersionUID = 1L;
	private final String message;
	
	public AdminNotExists() {
		message = "L'utente non è un amministratore";
	}
	
	public AdminNotExists(String message) {
		this.message = message;
	}
	
	@Override
	public String getMessage()
	{
		return message;
	}

}
