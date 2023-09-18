package it.project.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.Date;
import java.util.LinkedList;

import it.project.Utility;
import it.project.bean.AcquistoBean;
import it.project.storage.ConnectionPool;

public class AcquistoModel {
	
	public synchronized Collection<AcquistoBean> doRetrieveAll(String order) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		Collection<AcquistoBean> buys;
		AcquistoBean buy;
		try
		{
			buys = new LinkedList<>();
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("SELECT * FROM Acquisto ORDER BY DataAcquisto " + order);
			ResultSet set = ps.executeQuery();

			while (set.next()) 
			{
				buy = new AcquistoBean();
				buy.setIDAcquisto(set.getInt("IDAcquisto"));
				buy.setIDUtente(set.getInt("IDUtente"));
				buy.setIDGioco(set.getInt("IDGioco"));
				buy.setIDMetodo(set.getInt("IDMetodo"));
				buy.setQuantity(set.getInt("Quantita"));
				buy.setDate(set.getDate("DataAcquisto"));
				buys.add(buy);
			}
			
		} finally {
			try {
				if (ps != null)
					ps.close();
			} finally {
				ConnectionPool.releaseConnection(conn);
			}
		}
		return buys;
	}
	
	public synchronized boolean doSave(int IDUtente, int IDGioco, int IDMetodo, int quantity, Date date) throws SQLException 
	{
		Connection conn = null;
		PreparedStatement ps = null;
		boolean ok = false;
		try {
			conn = ConnectionPool.getConnection();
			ps = conn.prepareStatement("INSERT INTO Acquisto(IDUtente, IDGioco, IDMetodo, Quantita, DataAcquisto) VALUES(?, ?, ?, ?, ?)");
			ps.setInt(1, IDUtente);
			ps.setInt(2, IDGioco);
			ps.setInt(3, IDMetodo);
			ps.setInt(4, quantity);
			ps.setString(5,Utility.dateToMysql(date));
			ps.executeUpdate();
			conn.commit();
			ok = true;
		} 
		catch(Exception e){
			e.printStackTrace();
		}finally {
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
