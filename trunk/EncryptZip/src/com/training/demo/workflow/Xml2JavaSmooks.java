package com.training.demo.workflow;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import javax.xml.transform.stream.StreamSource;

import org.milyn.Smooks;
import org.milyn.container.ExecutionContext;
import org.milyn.io.StreamUtils;
import org.milyn.payload.JavaResult;

import com.training.demo.model.vo.*;


public class Xml2JavaSmooks {

	public static Smooks xml2JavaSmooks = null;
	static {
		try {
			xml2JavaSmooks = new Smooks("com/training/demo/workflow/config/config.xml");
		} catch (Exception e) {
			e.printStackTrace();
           
		}
	}
	
	public User getUserInfo(String fileName) {
		User user = new User();		
		try {			
			FileInputStream fileInputStream = new FileInputStream(new File(fileName));			
			byte[] messageIn = StreamUtils.readStream(fileInputStream);		
			
			JavaResult dataResult = new JavaResult();
			
			ExecutionContext dataContext = xml2JavaSmooks.createExecutionContext();
			
			xml2JavaSmooks.filter(new StreamSource(
					new ByteArrayInputStream(messageIn)),
					dataResult, 
					dataContext);
			user = (User) dataResult.getBean("user");
			
		} catch (Exception e) {
			e.printStackTrace();
			user = null;
		}	
		
		return user;
	}
	
	


}
