package com.training.demo.model.dao;

import java.util.List;
import com.training.commons.dao.IBaseDao;
import com.training.demo.model.vo.User;

public interface IUserDao extends IBaseDao<User, String> {
	
	List<?> saveOrUpdateAll(Object o)throws Exception;
	
	List<?> saveOrUpdate(Object o);
}