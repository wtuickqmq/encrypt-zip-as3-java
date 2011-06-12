package com.training.demo.model.dao.hibernate;

import java.util.Collection;
import java.util.List;

import org.springframework.dao.DataAccessException;
import com.training.demo.model.dao.IUserDao;
import com.training.demo.model.vo.User;

import com.training.commons.dao.hibernate.BaseDaoHibernate;

public class UserDao extends BaseDaoHibernate<User, String,IUserDao> implements IUserDao{
	
	
	@SuppressWarnings("unchecked")
	public List<?> saveOrUpdateAll(Object o) {		
		try {
			Collection<User> collection = (Collection<User>) o;
			this.saveOrUpdateAll(collection);
		} catch (DataAccessException e) {
			e.printStackTrace();
			throw e;
		}
		return null;
	}
	
	public List<?> saveOrUpdate(Object o) {
		try {
			User user = (User) o;
			this.saveOrUpdate(user);
		} catch (DataAccessException e) {
			e.printStackTrace();
			throw e;
		}

		return null;
	}
	
	
	
}


