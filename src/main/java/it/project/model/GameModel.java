package it.project.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import it.project.bean.GameBean;
import it.project.storage.ConnectionPool;

public class GameModel implements EntityBeanModel<GameBean>
{

	@Override
	public synchronized boolean doDelete(GameBean entity) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		int result = 0;

		try {
			
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("DELETE FROM Gioco WHERE Nome = ?");
			ps.setString(1, entity.getName());
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

	@Override
	public synchronized GameBean doRetrieveByKey(String key) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		GameBean game = new GameBean();

		try {
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("SELECT * FROM Gioco WHERE Nome = ?");
			ps.setString(1, key);

			ResultSet set = ps.executeQuery();

			while (set.next()) 
			{
				game.setName(set.getString("Nome"));
				game.setDescription(set.getString("Descrizione"));
				game.setPrice(set.getDouble("Prezzo"));
				game.setReleaseDate(set.getDate("DataRilascio"));
				game.setMinAge(set.getInt("EtaMinima"));
				game.setPreview(set.getString("PreviewUrl"));
				game.setAdminKey(set.getInt("IDAdmin"));
			}

		} finally {
			try {
				if (ps != null)
					ps.close();
			} finally {
				ConnectionPool.releaseConnection(conn);
			}
		}
		return game;
	}

	@Override
	public synchronized Collection<GameBean> doRetrieveAll(String order) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		Collection<GameBean> games;
		try
		{
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("SELECT * FROM Gioco ORDER BY " + order);
			games = new LinkedList<GameBean>();
			ResultSet set = ps.executeQuery();
			GameBean game;
			while(set.next())
			{
				game = new GameBean();
				game.setName(set.getString("Nome"));
				game.setDescription(set.getString("Descrizione"));
				game.setPrice(set.getDouble("Prezzo"));
				game.setReleaseDate(set.getDate("DataRilascio"));
				game.setMinAge(set.getInt("EtaMinima"));
				game.setPreview(set.getString("PreviewUrl"));
				game.setAdminKey(set.getInt("IDAdmin"));
				games.add(game);
			}
		} finally {
			try {
				if (ps != null)
					ps.close();
			} finally {
				ConnectionPool.releaseConnection(conn);
			}
		}
		return games;
	}

	@Override
	public synchronized boolean doSave(GameBean entity) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		boolean ok = false;
		
		try {
			
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("INSERT INTO Gioco(Nome, Descrizione, Prezzo, DataRilascio, EtaMinima, PreviewUrl, IDAdmin) VALUES (?, ?, ?, ?, ?, ?, ?)");
			ps.setString(1, entity.getName());
			ps.setString(2, entity.getDescription());
			ps.setDouble(3, entity.getPrice());
			ps.setDate(4, new java.sql.Date(entity.getReleaseDate().getTime()));
			ps.setInt(5, entity.getMinAge());
			ps.setString(6, entity.getPreview());
			ps.setInt(7, entity.getAdminKey());
			ps.executeUpdate();
			conn.commit();
			ok = true;
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
