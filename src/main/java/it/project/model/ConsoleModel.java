package it.project.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import it.project.bean.ConsoleBean;
import it.project.storage.ConnectionPool;

public class ConsoleModel implements EntityBeanModel<ConsoleBean>
{

	@Override
	public synchronized boolean doDelete(ConsoleBean entity) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		int result = 0;

		EsecuzioneGiocoModel.doDeleteByConsole(entity);
		
		try {
			
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("DELETE FROM Console WHERE Nome = ?");
			ps.setString(1, entity.getName());
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

	@Override
	public synchronized ConsoleBean doRetrieveByKey(String name) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		ConsoleBean console = new ConsoleBean();

		try {
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("SELECT * FROM Console WHERE Nome = ?");
			ps.setString(1, name);

			ResultSet set = ps.executeQuery();

			while (set.next()) 
			{
				console.setName(set.getString("Nome"));
				console.setDescription(set.getString("Descrizione"));
			}

		} finally {
			try {
				if (ps != null)
					ps.close();
			} finally {
				ConnectionPool.releaseConnection(conn);
			}
		}
		return console;
	}

	@Override
	public synchronized Collection<ConsoleBean> doRetrieveAll(String order) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		Collection<ConsoleBean> consoles;
		try
		{
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("SELECT * FROM Console ORDER BY Nome " + order);
			consoles = new LinkedList<ConsoleBean>();
			ResultSet set = ps.executeQuery();
			ConsoleBean console;
			while(set.next())
			{
				console = new ConsoleBean();
				console.setName(set.getString("Nome"));
				console.setDescription(set.getString("Descrizione"));
				consoles.add(console);
			}
		} finally {
			try {
				if (ps != null)
					ps.close();
			} finally {
				ConnectionPool.releaseConnection(conn);
			}
		}
		return consoles;
	}

	@Override
	public synchronized boolean doSave(ConsoleBean entity) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		boolean ok = false;
		
		try {
			
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("INSERT INTO Console(Nome, Descrizione) VALUES (?, ?)");
			ps.setString(1, entity.getName());
			ps.setString(2, entity.getDescription());
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

	@Override
	public int doRetrieveKey(String name) throws SQLException {
		int key = -1;
		
		Connection conn = null;
		PreparedStatement ps = null;

		try {
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("SELECT * FROM Console WHERE Nome = ?");
			ps.setString(1, name);

			ResultSet set = ps.executeQuery();

			while (set.next()) 
			{
				key = set.getInt("IDConsole");
			}

		} finally {
			try {
				if (ps != null)
					ps.close();
			} finally {
				ConnectionPool.releaseConnection(conn);
			}
		}
		
		return key;
	}

	@Override
	public boolean doUpdate(ConsoleBean entity) throws SQLException {
		
		Connection conn = null;
		PreparedStatement ps = null;
		boolean ok = false;
		
		try {
			
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("UPDATE Console SET Descrizione = ? WHERE Nome = ?");
			ps.setString(1, entity.getDescription());
			ps.setString(2, entity.getName());
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
