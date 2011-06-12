package com.training.commons.dao.jdbc;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;

public class BaseJdbcDaoSupport  {
	protected Log logger = LogFactory.getLog(this.getClass());
	protected NamedParameterJdbcTemplate sqlTemplate;
	
	protected SqlParameterSource sqlParm ;
	
	protected JdbcTemplate jdbcTemplate;
	protected String sql="";

	public NamedParameterJdbcTemplate getSqlTemplate() {
		return sqlTemplate;
	}

	public void setSqlTemplate(NamedParameterJdbcTemplate sqlTemplate) {
		this.sqlTemplate = sqlTemplate;
	}

	public SqlParameterSource getSqlParm(Object sqlParm) {
		return new BeanPropertySqlParameterSource(sqlParm);
	}


	public JdbcTemplate getJdbcTemplate() {
		return jdbcTemplate;
	}

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

}
