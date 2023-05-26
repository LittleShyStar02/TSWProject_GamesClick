package it.project.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import it.project.bean.CategoryBean;
import it.project.bean.GameBean;
import it.project.storage.ConnectionPool;

public class CategoriaGiocoModel 
{
	
	public synchronized static boolean doDeleteByCategory(CategoryBean entity) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		int result = 0;

		try {
			
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("DELETE FROM CategoriaGioco WHERE IDCategoria = ?");
			ps.setInt(1, new CategoryModel().doRetrieveKey(entity.getName()));
			result = ps.executeUpdate();

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
	
	public synchronized static boolean doDeleteByGame(GameBean entity) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		int result = 0;

		try {
			
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("DELETE FROM CategoriaGioco WHERE IDGioco = ?");
			ps.setInt(1, new GameModel().doRetrieveKey(entity.getName()));
			result = ps.executeUpdate();

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
	
	public synchronized static boolean doSave(String category_key,String game_key) throws SQLException
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
			ps.setString(1, category_key);
			ps.setString(2, game_key);
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

}
