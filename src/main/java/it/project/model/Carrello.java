package it.project.model;

import java.util.HashMap;

import it.project.bean.GameBean;

public class Carrello 
{
	
	@Override
	public String toString() {
		return "Carrello [product=" + product + "]";
	}

	private HashMap<String,Integer> product;
	
	public Carrello(){
		product = new HashMap<>();
	}
	
	public void addProduct(GameBean game)
	{
		addProduct(game,1);
	}
	
	public void addProduct(GameBean game,int quantity)
	{
		if(!product.containsKey(game.getName()))
		{
			if(quantity <= 0)
			{
				product.put(game.getName(), 1);
			}
			else
			{
				product.put(game.getName(), quantity);
			}
		}
	}
	
	public HashMap<String,Integer> getProducts()
	{
		return product;
	}
	
	public void removeProduct(GameBean game)
	{
		if(product.containsKey(game.getName()))
		{
			product.remove(game.getName());
		}
		
	}
	
	public void updateGame(GameBean game,int quantity)
	{
		if(product.containsKey(game.getName()))
		{
			product.replace(game.getName(), quantity);
		}
		
	}
	
	public boolean isEmpty()
	{
		return product.isEmpty();
	}

}
