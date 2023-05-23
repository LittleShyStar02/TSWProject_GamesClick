package it.project.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import it.project.bean.UserBean;
import it.project.storage.ConnectionPool;

public class UserModel implements EntityBeanModel<UserBean>
{
	
	@Override
	public synchronized boolean doDelete(UserBean entity) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null,ps2 = null;
		int result = 0;
		
		try {
			
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("DELETE FROM Utente WHERE Email = ?");
			ps2 = conn.prepareStatement("DELETE FROM Amministratore WHERE Email = ?");
			ps.setString(1, entity.getEmail());
			ps2.setString(1, entity.getEmail());
			result = ps.executeUpdate();
			ps2.executeUpdate();

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

	@Override
	public synchronized UserBean doRetrieveByKey(String key) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null, ps2= null;
		UserBean user = new UserBean();

		try {
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("SELECT * FROM Utente WHERE Email = ?");
			ps.setString(1, key);

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
				set2.last();
				user.setAdmin(set2.getRow() != 0);
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

	@Override
	public synchronized Collection<UserBean> doRetrieveAll(String order) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null,ps2=null;
		Collection<UserBean> users;
		UserBean user;
		try
		{
			users = new LinkedList<UserBean>();
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("SELECT * FROM Utente ORDER BY " + order);
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
				set2.last();
				user.setAdmin(set2.getRow() != 0);
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
	public synchronized void doSave(UserBean entity) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;

		try {
			
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("INSERT INTO Gioco(Nome, Cognome, Email, Password, DataNascita, Indirizzo) VALUES (?, ?, ?, ?, ?, ?)");
			ps.setString(1, entity.getName());
			ps.setString(2, entity.getSurname());
			ps.setString(3, entity.getEmail());
			ps.setString(4, entity.getPassword());
			ps.setDate(5, new java.sql.Date(entity.getBornDate().getTime()));
			ps.setString(6, entity.getAddress());
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
		
	}

}
