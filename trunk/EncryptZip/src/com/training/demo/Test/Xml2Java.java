/**
 * Copyright (c) 2009 David Yao (xiang.okay@gmail.com)
 * description: Test the function of Encryption and Decrytion the zipfile 
 *  with password
 * author: David Yao
 * mail: xiang.okay@gmail.com
 */

package com.training.demo.Test;

import com.training.demo.model.vo.User;
import com.training.demo.workflow.Xml2JavaSmooks;
import org.junit.Test;

public class Xml2Java {	

	
	public static final String file = "com/training/demo/workflow/config/input.xml";
	
	@Test
	public void TestXml2Java(){
		String fileName;
		fileName = Xml2Java.class.getClassLoader().getResource(file).getFile();
		Xml2JavaSmooks smooks = new Xml2JavaSmooks();		
		User user = smooks.getUserInfo(fileName);			
		if(user != null){
				System.out.println(user.getUserName());
				System.out.println(user.getPassword());
				System.out.println(user.getState());
		}		
			
	}
	
	 
	
	
	
	

}
