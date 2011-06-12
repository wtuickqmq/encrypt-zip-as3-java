package com.training.commons.dao.hibernate;

import java.io.Serializable;
import java.lang.reflect.ParameterizedType;
import java.util.Collection;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.LockMode;
import org.springframework.dao.DataAccessException;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;

import com.training.commons.dao.IBaseDao;

public class BaseDaoHibernate<T, PK extends Serializable, DAOImpl extends IBaseDao<T, PK>>
		extends HibernateDaoSupport implements IBaseDao<T, PK> {
	
	protected Log logger = LogFactory.getLog(getClass());

	protected Class<T> entityClass;

	public BaseDaoHibernate() {

	}

	@SuppressWarnings("unchecked")
	protected Class getEntityClass() {
		if (entityClass == null) {
			entityClass = (Class<T>) ((ParameterizedType) getClass()
					.getGenericSuperclass()).getActualTypeArguments()[0];
			logger.debug("T class = " + entityClass.getName());
		}
		return entityClass;
	}

	public void saveOrUpdate(T t) {
//		this.getHibernateTemplate().saveOrUpdate(t);
		 this.getHibernateTemplate().merge(t);
	}

	@SuppressWarnings("unchecked")
	public T load(Serializable PK) {

		T load = (T) getHibernateTemplate().load(getEntityClass(), PK);
		return load;
	}

	@SuppressWarnings("unchecked")
	public T get(Serializable PK) {
		T load = (T) getHibernateTemplate().get(getEntityClass(), PK);
		return load;
	}

	public boolean contains(T t) throws DataAccessException {
		return getHibernateTemplate().contains(t);
	}

	public void delete(T t, LockMode lockMode) throws DataAccessException {
		getHibernateTemplate().delete(t, lockMode);
	}

	public void delete(T t) throws DataAccessException {
		getHibernateTemplate().delete(t);

	}

	public void deleteAll(Collection<T> entities) throws DataAccessException {
		getHibernateTemplate().deleteAll(entities);
	}

	@SuppressWarnings("unchecked")
	public List<T> find(String queryString, Object value)
			throws DataAccessException {
		List<T> find = (List<T>) getHibernateTemplate()
				.find(queryString, value);
		return find;
	}

	@SuppressWarnings("unchecked")
	public List<T> find(String queryString, Object[] values)
			throws DataAccessException {
		List<T> find = (List<T>) getHibernateTemplate().find(queryString,
				values);
		return find;
	}

	@SuppressWarnings("unchecked")
	public List<T> find(String queryString) throws DataAccessException {
		return (List<T>) getHibernateTemplate().find(queryString);
	}

	@SuppressWarnings("unchecked")
	public List<T> findByExample(Object exampleEntity, int firstResult,
			int maxResults) throws DataAccessException {
		return getHibernateTemplate().findByExample(exampleEntity, firstResult,
				maxResults);
	}

	@SuppressWarnings("unchecked")
	public List<T> findByExample(Object exampleEntity)
			throws DataAccessException {
		return getHibernateTemplate().findByExample(exampleEntity);
	}

	@SuppressWarnings("unchecked")
	public List<T> findByNamedParam(String queryString, String paramName,
			Object value) throws DataAccessException {
		return getHibernateTemplate().findByNamedParam(queryString, paramName,
				value);
	}

	@SuppressWarnings("unchecked")
	public List<T> findByNamedParam(String queryString, String[] paramNames,
			Object[] values) throws DataAccessException {
		return getHibernateTemplate().findByNamedParam(queryString, paramNames,
				values);
	}

	@SuppressWarnings("unchecked")
	public Object load(Class TClass, Serializable PK, LockMode lockMode)
			throws DataAccessException {
		return getHibernateTemplate().load(TClass, PK, lockMode);
	}

	public void load(T t, Serializable PK) throws DataAccessException {
		getHibernateTemplate().load(t, PK);
	}

	public Object load(String TName, Serializable PK, LockMode lockMode)
			throws DataAccessException {
		return getHibernateTemplate().load(TName, PK, lockMode);
	}

	public Object load(String TName, Serializable PK)
			throws DataAccessException {
		return getHibernateTemplate().load(TName, PK);
	}

	public void refresh(T t, LockMode lockMode) throws DataAccessException {
		getHibernateTemplate().refresh(t, lockMode);
	}

	public void refresh(T t) throws DataAccessException {
		getHibernateTemplate().refresh(t);
	}

	public Serializable save(T t) throws DataAccessException {
		return getHibernateTemplate().save(t);
	}

	public void saveOrUpdate(String TName, T t) throws DataAccessException {
		getHibernateTemplate().saveOrUpdate(TName, t);
	}

	public void saveOrUpdateAll(Collection<T> entities)
			throws DataAccessException {
		getHibernateTemplate().saveOrUpdateAll(entities);
	}

	public void update(T t, LockMode lockMode) throws DataAccessException {
		getHibernateTemplate().update(t, lockMode);
	}

	public void update(T t) throws DataAccessException {
		getHibernateTemplate().update(t);
	}

	public void update(String TName, T t, LockMode lockMode)
			throws DataAccessException {
		getHibernateTemplate().update(TName, t, lockMode);
	}

	public void update(String TName, T t) throws DataAccessException {
		getHibernateTemplate().update(TName, t);
	}

	@SuppressWarnings("unchecked")
	public List<T> loadAll() {
		return getHibernateTemplate().loadAll(getEntityClass());

	}

	@SuppressWarnings("unchecked")
	public List<T> list() {
		Criteria criteria = getSession().createCriteria(getEntityClass());
		return criteria.list();

	}

}
