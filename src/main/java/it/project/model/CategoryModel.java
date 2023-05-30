package it.project.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import it.project.bean.CategoryBean;
import it.project.storage.ConnectionPool;

public class CategoryModel implements EntityBeanModel<CategoryBean>
{

	@Override
	public synchronized boolean doDelete(CategoryBean entity) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		int result = 0;
		
		CategoriaGiocoModel.doDeleteByCategory(entity);
		
		try {
			
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("DELETE FROM Categoria WHERE Nome = ?");
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
	public synchronized CategoryBean doRetrieveByKey(String name) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		CategoryBean cat = new CategoryBean();

		try {
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("SELECT * FROM Categoria WHERE Nome = ?");
			ps.setString(1, name);

			ResultSet set = ps.executeQuery();

			while (set.next()) 
			{
				cat.setName(set.getString("Nome"));
				cat.setDescription(set.getString("Descrizione"));
			}

		} finally {
			try {
				if (ps != null)
					ps.close();
			} finally {
				ConnectionPool.releaseConnection(conn);
			}
		}
		return cat;
	}

	@Override
	public synchronized Collection<CategoryBean> doRetrieveAll(String order) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		Collection<CategoryBean> cats;
		try
		{
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("SELECT * FROM Categoria ORDER BY " + order);
			cats = new LinkedList<CategoryBean>();
			ResultSet set = ps.executeQuery();
			CategoryBean cat;
			while(set.next())
			{
				cat = new CategoryBean();
				cat.setName(set.getString("Nome"));
				cat.setDescription(set.getString("Descrizione"));
				cats.add(cat);
			}
		} finally {
			try {
				if (ps != null)
					ps.close();
			} finally {
				ConnectionPool.releaseConnection(conn);
			}
		}
		return cats;
	}

	@Override
	public synchronized boolean doSave(CategoryBean entity) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		boolean ok = false;
		
		try {
			
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("INSERT INTO Categoria(Nome, Descrizione) VALUES (?, ?)");
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
			ps = conn.prepareStatement("SELECT * FROM Categoria WHERE Nome = ?");
			ps.setString(1, name);

			ResultSet set = ps.executeQuery();

			while (set.next()) 
			{
				key = set.getInt("IDCategoria");
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
	public boolean doUpdate(CategoryBean entity) throws SQLException {
		
		Connection conn = null;
		PreparedStatement ps = null;
		boolean ok = false;
		
		try {
			
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("UPDATE Categoria SET Descrizione = ? WHERE Nome = ?");
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
