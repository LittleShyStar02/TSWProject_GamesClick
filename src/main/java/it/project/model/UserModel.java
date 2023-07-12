package it.project.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import it.project.Utility;
import it.project.bean.UserBean;
import it.project.exception.AdminExists;
import it.project.exception.AdminNotExists;
import it.project.storage.ConnectionPool;

public class UserModel implements EntityBeanModel<UserBean>
{
	
	@Override
	public synchronized boolean doDelete(UserBean entity) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		PreparedStatement ps2 = null;
		int result = 0;
		
		try {
			
			conn = ConnectionPool.getConnection();
			ps2 = conn.prepareStatement("DELETE FROM Amministratore WHERE Email = ?");
			ps2.setString(1, entity.getEmail());
			ps2.executeUpdate();
			conn.commit();
			
			ps = conn.prepareStatement("DELETE FROM Utente WHERE Email = ?");
			ps.setString(1, entity.getEmail());
			result = ps.executeUpdate();
			conn.commit();
		} finally {
			try {
				if(ps != null) ps.close();
				if(ps2 != null) ps2.close();
			} finally {
				ConnectionPool.releaseConnection(conn);
			}
		}
		return (result != 0);
	}
	
	public synchronized boolean doDeleteAdmin(UserBean entity) throws SQLException, AdminNotExists 
	{
		if(!entity.isAdmin()) throw new AdminNotExists(); 
		Connection conn = null;
		PreparedStatement ps = null;
		int result = 0;
		
		try {
			
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("DELETE FROM Amministratore WHERE Email = ?");
			ps.setString(1, entity.getEmail());
			result = ps.executeUpdate();
			conn.commit();
		} finally {
			try {
				if(ps != null) ps.close();
			} finally {
				ConnectionPool.releaseConnection(conn);
			}
		}
		return (result != 0);
	}

	@Override
	public synchronized UserBean doRetrieveByKey(String email) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		PreparedStatement ps2= null;
		UserBean user = new UserBean();

		try {
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("SELECT * FROM Utente WHERE Email = ?");
			ps.setString(1, email);

			ResultSet set = ps.executeQuery();

			while (set.next()) 
			{
				user.setName(set.getString("Nome"));
				user.setSurname(set.getString("Cognome"));
				user.setEmail(set.getString("Email"));
				user.setPassword(set.getString("Password"));
				user.setBornDate(set.getDate("DataNascita"));
				user.setAddress(set.getString("Indirizzo"));
				
				ps2 = conn.prepareStatement("SELECT * FROM Amministratore WHERE Email = ?");
				ps2.setString(1,user.getEmail());
				ResultSet set2 = ps2.executeQuery();
				while(set2.next())
				{
					user.setAdmin(set2.getRow() != 0);
				}
				ps2.close();
			}

		} finally {
			try {
				if (ps != null)
					ps.close();
			} finally {
				ConnectionPool.releaseConnection(conn);
			}
		}
		return user;
	}
	
	public synchronized String adminMailByKey(int id) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		String mail = null;

		try {
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("SELECT * FROM Amministratore WHERE IDAdmin = ?");
			ps.setInt(1, id);

			ResultSet set = ps.executeQuery();
			
			while (set.next()) 
			{
				mail = set.getString("Email");
			}

		} finally {
			try {
				if (ps != null)
					ps.close();
			} finally {
				ConnectionPool.releaseConnection(conn);
			}
		}
		return mail;
	}

	@Override
	public synchronized Collection<UserBean> doRetrieveAll(String order) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		PreparedStatement ps2=null;
		Collection<UserBean> users;
		UserBean user;
		try
		{
			users = new LinkedList<>();
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("SELECT * FROM Utente ORDER BY Nome,Cognome,Email " + order);
			ResultSet set = ps.executeQuery();

			while (set.next()) 
			{
				user = new UserBean();
				user.setName(set.getString("Nome"));
				user.setSurname(set.getString("Cognome"));
				user.setEmail(set.getString("Email"));
				user.setPassword(set.getString("Password"));
				user.setBornDate(set.getDate("DataNascita"));
				user.setAddress(set.getString("Indirizzo"));
				
				ps2 = conn.prepareStatement("SELECT * FROM Amministratore WHERE Email = ?");
				ps2.setString(1,user.getEmail());
				ResultSet set2 = ps2.executeQuery();
				while(set2.next())
				{
					user.setAdmin(set2.getRow() != 0);
				}
				ps2.close();
			}
			
		} finally {
			try {
				if (ps != null)
					ps.close();
			} finally {
				ConnectionPool.releaseConnection(conn);
			}
		}
		return users;
	}

	@Override
	public synchronized boolean doSave(UserBean entity) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		boolean ok = false;
		try {
			
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("INSERT INTO Utente(Nome, Cognome, Email, Password, DataNascita, Indirizzo) VALUES (?, ?, ?, ?, ?, ?)");
			ps.setString(1, entity.getName());
			ps.setString(2, entity.getSurname());
			ps.setString(3, entity.getEmail());
			ps.setString(4, entity.getPassword());
			ps.setString(5, Utility.dateToMysql(entity.getBornDate()));
			ps.setString(6, entity.getAddress());
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
	
	public synchronized boolean doSaveAdmin(UserBean entity) throws SQLException, AdminExists 
	{
		if(entity.isAdmin()) throw new AdminExists();
		Connection conn = null;
		PreparedStatement ps = null;
		boolean ok = false;
		try {
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("INSERT INTO Amministratore(Email) VALUES (?)");
			ps.setString(1, entity.getEmail());
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
	public int doRetrieveKey(String email) throws SQLException {
		int key = -1;
		
		Connection conn = null;
		PreparedStatement ps = null;

		try {
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("SELECT * FROM Utente WHERE Email = ?");
			ps.setString(1, email);

			ResultSet set = ps.executeQuery();

			while (set.next()) 
			{
				key = set.getInt("IDUtente");
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
	
	public String doRetrieveEmailById(int id) throws SQLException {
		
		Connection conn = null;
		PreparedStatement ps = null;
		String email = null;
		
		try {
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("SELECT * FROM Utente WHERE IDUtente = ?");
			ps.setInt(1, id);

			ResultSet set = ps.executeQuery();

			while (set.next()) 
			{
				email = set.getString("Email");
			}

		} finally {
			try {
				if (ps != null)
					ps.close();
			} finally {
				ConnectionPool.releaseConnection(conn);
			}
		}
		
		return email;
	}
	
	public int doRetrieveAdminKey(String email) throws SQLException {
		int key = -1;
		
		Connection conn = null;
		PreparedStatement ps = null;

		try {
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("SELECT * FROM Amministratore WHERE Email = ?");
			ps.setString(1, email);

			ResultSet set = ps.executeQuery();

			while (set.next()) 
			{
				key = set.getInt("IDAdmin");
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
	public boolean doUpdate(UserBean entity) throws SQLException {
		return false;
	}

}
