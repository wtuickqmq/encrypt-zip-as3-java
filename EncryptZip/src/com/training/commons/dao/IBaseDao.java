package com.training.commons.dao;

import java.io.Serializable;
import java.util.Collection;
import java.util.List;

import org.hibernate.LockMode;
import org.springframework.dao.DataAccessException;

public interface IBaseDao<T, PK extends Serializable> {

	public void saveOrUpdate(T t);

	public T load(Serializable PK);

	public T get(Serializable PK);

	public boolean contains(T t) throws DataAccessException;

	public void delete(T t, LockMode lockMode) throws DataAccessException;

	public void delete(T t) throws DataAccessException;

	public void deleteAll(Collection<T> entities) throws DataAccessException;

	public List<T> find(String queryString, Object value)
			throws DataAccessException;

	public List<T> find(String queryString, Object[] values)
			throws DataAccessException;

	public List<T> find(String queryString) throws DataAccessException;

	// 通过给定的一个对象，查找与其匹配的对象。
	public List<T> findByExample(Object exampleEntity, int firstResult,
			int maxResults) throws DataAccessException;

	public List<T> findByExample(Object exampleEntity)
			throws DataAccessException;

	public List<T> findByNamedParam(String queryString, String paramName,
			Object value) throws DataAccessException;

	public List<T> findByNamedParam(String queryString, String[] paramNames,
			Object[] values) throws DataAccessException;

	public Object load(Class<?> TClass, Serializable PK, LockMode lockMode)
			throws DataAccessException;

	public void load(T t, Serializable PK) throws DataAccessException;

	public Object load(String TName, Serializable PK, LockMode lockMode)
			throws DataAccessException;

	public Object load(String TName, Serializable PK)
			throws DataAccessException;

	public void refresh(T t, LockMode lockMode) throws DataAccessException;

	public void refresh(T t) throws DataAccessException;

	public Serializable save(T t) throws DataAccessException;

	public void saveOrUpdate(String TName, T t) throws DataAccessException;

	public void saveOrUpdateAll(Collection<T> entities)
			throws DataAccessException;

	public void update(T t, LockMode lockMode) throws DataAccessException;

	public void update(T t) throws DataAccessException;

	public void update(String TName, T t, LockMode lockMode)
			throws DataAccessException;

	public void update(String TName, T t) throws DataAccessException;

	public List<T> loadAll();

	public List<T> list();

}