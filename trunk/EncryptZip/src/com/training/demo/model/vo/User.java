package com.training.demo.model.vo;




/**
 * BillInfo entity. @author MyEclipse Persistence Tools
 */

public class User implements java.io.Serializable {
	
	
	private static final long serialVersionUID = 1L;

	private Integer id;
	private String userName;
	private String password;
	private Integer state;

	
	
	/** default constructor */
	public User() {
	}

	/** minimal constructor */
	public User(Integer id) {
		this.id = id;
	}

	/** full constructor */
	public User(String userName, String password,Integer state,
			Integer id) {
		    this.userName = userName;
		    this.password = password;
		    this.state = state;
			this.id = id;
	}
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}

	public Integer getState() {
		return state;
	}

	public void setState(Integer state) {
		this.state = state;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}
	
	
	
	
	

}