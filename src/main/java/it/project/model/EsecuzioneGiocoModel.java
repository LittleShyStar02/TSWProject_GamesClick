package it.project.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import it.project.bean.ConsoleBean;
import it.project.bean.GameBean;
import it.project.storage.ConnectionPool;

public class EsecuzioneGiocoModel 
{
	
	private EsecuzioneGiocoModel() {}
	
	public static synchronized boolean doDeleteByConsole(ConsoleBean entity) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		int result = 0;

		try {
			
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("DELETE FROM EsecuzioneGioco WHERE IDConsole = ?");
			ps.setInt(1, new ConsoleModel().doRetrieveKey(entity.getName()));
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
			ps = conn.prepareStatement("DELETE FROM EsecuzioneGioco WHERE IDGioco = ?");
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
	
	public static synchronized boolean doSave(String console_key,String game_key) throws SQLException
	{
		Connection conn = null;
		PreparedStatement ps = null;
		boolean ok = false;
		
		GameBean gb = new GameModel().doRetrieveByKey(game_key);
		if(gb.getName() == null) return ok;
		
		ConsoleBean cb = new ConsoleModel().doRetrieveByKey(console_key);
		if(cb.getName() == null) return ok;
		
		try {
			
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("INSERT INTO EsecuzioneGioco(IDConsole, IDGioco) VALUES (?, ?)");
			ps.setInt(1, new ConsoleModel().doRetrieveKey(cb.getName()));
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
	
	public static synchronized boolean exists(String con,String game) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		try
		{
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("SELECT * FROM EsecuzioneGioco WHERE IDConsole = ? AND IDGioco = ?");
			ps.setInt(1, new ConsoleModel().doRetrieveKey(con));
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
