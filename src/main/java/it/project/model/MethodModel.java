package it.project.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import it.project.bean.MethodBean;
import it.project.storage.ConnectionPool;

public class MethodModel implements EntityBeanModel<MethodBean>
{

	@Override
	public synchronized boolean doDelete(MethodBean entity) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		int result = 0;
		
		try {
			
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("DELETE FROM Metodo WHERE Nome = ? AND Info = ? AND IDUtente = ?");
			ps.setString(1, entity.getName());
			ps.setString(2,entity.getInfo());
			ps.setInt(3, new UserModel().doRetrieveKey(entity.getEmail()));
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
	public MethodBean doRetrieveByKey(String name) {
		return null;
	}
	
	public synchronized MethodBean doRetrieveByKey(String name,String info,String email) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		MethodBean met = new MethodBean();

		try {
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("SELECT * FROM Metodo WHERE Nome = ? AND Info = ? AND IDUtente = ?");
			ps.setString(1, name);
			ps.setString(2, info);
			ps.setInt(3, new UserModel().doRetrieveKey(email));

			ResultSet set = ps.executeQuery();

			while (set.next()) 
			{
				met.setName(set.getString("Nome"));
				met.setInfo(set.getString("Info"));
				met.setEmail(new UserModel().doRetrieveEmailById(set.getInt("IDUtente")));
			}

		} finally {
			try {
				if (ps != null)
					ps.close();
			} finally {
				ConnectionPool.releaseConnection(conn);
			}
		}
		return met;
	}

	@Override
	public synchronized Collection<MethodBean> doRetrieveAll(String order) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		Collection<MethodBean> mets;
		try
		{
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("SELECT * FROM Metodo ORDER BY Nome,Info,IDUtente " + order);
			mets = new LinkedList<>();
			ResultSet set = ps.executeQuery();
			MethodBean met;
			while(set.next())
			{
				met = new MethodBean();
				met.setName(set.getString("Nome"));
				met.setInfo(set.getString("Info"));
				met.setEmail(new UserModel().doRetrieveEmailById(set.getInt("IDUtente")));
				mets.add(met);
			}
		} finally {
			try {
				if (ps != null)
					ps.close();
			} finally {
				ConnectionPool.releaseConnection(conn);
			}
		}
		return mets;
	}

	@Override
	public synchronized boolean doSave(MethodBean entity) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		boolean ok = false;
		
		try {
			
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("INSERT INTO Metodo(Nome, Info, IDUtente) VALUES (?, ?,?)");
			ps.setString(1, entity.getName());
			ps.setString(2, entity.getInfo());
			ps.setInt(3, new UserModel().doRetrieveKey(entity.getEmail()));
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
	public int doRetrieveKey(String info) throws SQLException
	{
		return -1;
	}
	
	public int doRetrieveKey(String name,String info,String email) throws SQLException {
		int key = -1;
		
		Connection conn = null;
		PreparedStatement ps = null;

		try {
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("SELECT * FROM Metodo WHERE Nome = ? AND Info = ? AND IDUtente = ?");
			ps.setString(1, name);
			ps.setString(2, info);
			ps.setInt(3, new UserModel().doRetrieveKey(email));

			ResultSet set = ps.executeQuery();

			while (set.next()) 
			{
				key = set.getInt("IDMetodo");
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
	public boolean doUpdate(MethodBean entity) throws SQLException {
		return false;
	}

}
