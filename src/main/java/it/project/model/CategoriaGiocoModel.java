package it.project.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import it.project.bean.CategoryBean;
import it.project.bean.GameBean;
import it.project.storage.ConnectionPool;

public class CategoriaGiocoModel 
{
	
	private CategoriaGiocoModel() {}
	
	public static synchronized boolean doDeleteByCategory(CategoryBean entity) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		int result = 0;

		try {
			
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("DELETE FROM CategoriaGioco WHERE IDCategoria = ?");
			ps.setInt(1, new CategoryModel().doRetrieveKey(entity.getName()));
			result = ps.executeUpdate();
			conn.commit();
		} finally {
			try {
				if (ps != null)
					ps.close();
			} finally {
				ConnectionPool.releaseConnection(conn);
			}
		}
		return (result != 0);
	}
	
	public static synchronized boolean doDeleteByGame(GameBean entity) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		int result = 0;

		try {
			
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("DELETE FROM CategoriaGioco WHERE IDGioco = ?");
			ps.setInt(1, new GameModel().doRetrieveKey(entity.getName()));
			result = ps.executeUpdate();
			conn.commit();
		} finally {
			try {
				if (ps != null)
					ps.close();
			} finally {
				ConnectionPool.releaseConnection(conn);
			}
		}
		return (result != 0);
	}
	
	public static synchronized boolean doSave(String category_key,String game_key) throws SQLException
	{
		Connection conn = null;
		PreparedStatement ps = null;
		boolean ok = false;
		
		GameBean gb = new GameModel().doRetrieveByKey(game_key);
		if(gb.getName() == null) return ok;
		
		CategoryBean cb = new CategoryModel().doRetrieveByKey(category_key);
		if(cb.getName() == null) return ok;
		
		try {
			
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("INSERT INTO CategoriaGioco(IDCategoria, IDGioco) VALUES (?, ?)");
			ps.setInt(1, new CategoryModel().doRetrieveKey(cb.getName()));
			ps.setInt(2, new GameModel().doRetrieveKey(gb.getName()));
			ps.executeUpdate();
			conn.commit();
		} finally {
			try {
				if (ps != null)
					ps.close();
			} finally {
				ConnectionPool.releaseConnection(conn);
			}
		}
		return ok;
	}
	
	public static synchronized boolean exists(String cat,String game) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		try
		{
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("SELECT * FROM CategoriaGioco WHERE IDCategoria = ? AND IDGioco = ?");
			ps.setInt(1, new CategoryModel().doRetrieveKey(cat));
			ps.setInt(2, new GameModel().doRetrieveKey(game));
			ResultSet set = ps.executeQuery();
			int count = 0;
			while(set.next())
			{
				count++;
			}
			if(count > 0) return true;
		} finally {
			try {
				if (ps != null)
					ps.close();
			} finally {
				ConnectionPool.releaseConnection(conn);
			}
		}
		return false;
	}

}
