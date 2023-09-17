package it.project.bean;

import java.util.Date;

public class AcquistoBean {
	
	private int IDAcquisto;
	private int IDUtente;
	private int IDGioco;
	private int IDMetodo;
	private int Quantita;
	private Date DataAcquisto;
	
	public void setIDAcquisto(int id)
	{
		this.IDAcquisto = id;
	}
	
	public void setIDUtente(int id)
	{
		this.IDUtente = id;
	}
	
	public void setIDGioco(int id)
	{
		this.IDGioco = id;
	}
	
	public void setIDMetodo(int id)
	{
		this.IDMetodo = id;
	}
	
	public void setQuantity(int amount)
	{
		this.Quantita = amount;
	}
	
	public void setDate(Date date)
	{
		this.DataAcquisto = date;
	}
	
	public int getIDAcquisto()
	{
		return this.IDAcquisto;
	}
	
	public int getIDUtente()
	{
		return this.IDUtente;
	}
	
	public int getIDGioco()
	{
		return this.IDGioco;
	}
	
	public int getIDMetodo()
	{
		return this.IDMetodo;
	}
	
	public int getQuantity()
	{
		return this.Quantita;
	}
	
	public Date getDate()
	{
		return this.DataAcquisto;

}

}
