package it.project.model;

import java.sql.SQLException;
import java.util.Collection;

public interface EntityBeanModel<Type>
{
	
	public boolean doDelete(Type entity) throws SQLException;
	public int doRetrieveKey(String newkey) throws SQLException;
	public Type doRetrieveByKey(String key) throws SQLException;
	public Collection<Type> doRetrieveAll(String order) throws SQLException;
	public boolean doSave(Type entity) throws SQLException;

}
