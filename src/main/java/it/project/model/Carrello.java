package it.project.model;

import java.util.HashMap;

import it.project.bean.GameBean;

public class Carrello 
{
	
	@Override
	public String toString() {
		return "Carrello [product=" + product + ", quantity=" + quantity + "]";
	}

	private HashMap<String,GameBean> product;
	private HashMap<String,Integer> quantity;
	
	public Carrello(){
		product = new HashMap<>();
		quantity = new HashMap<>();
	}
	
	public void addProduct(GameBean game)
	{
		addProduct(game,1);
	}
	
	public void addProduct(GameBean game,int amount)
	{
		if(!product.containsKey(game.getName()))
		{
			product.put(game.getName(), game);
			if(amount != 0)
			{
				quantity.put(game.getName(), amount);
			}
			else quantity.put(game.getName(), 1);
		}
	}
	
	public HashMap<String,GameBean> getProducts()
	{
		return product;
	}
	
	public HashMap<String,Integer> getQuantity()
	{
		return quantity;
	}
	
	public void removeProduct(GameBean game)
	{
		if(product.containsKey(game.getName()))
		{
			product.remove(game.getName(), game);
		}
		
		if(quantity.containsKey(game.getName()))
		{
			quantity.remove(game.getName(),quantity.get(game.getName()));
		}
	}
	
	public boolean isEmpty()
	{
		return product.isEmpty();
	}

}
