package com.training.demo.service;
import com.training.demo.model.vo.*;
import com.training.demo.workflow.*;


import flex.messaging.MessageBroker;
import flex.messaging.messages.AsyncMessage;
import flex.messaging.util.UUIDUtils;

public class PushMessageService{
	

	public void pushmessage() {
		MessageBroker msgBroker = MessageBroker.getMessageBroker(null);
		String clientID = UUIDUtils.createUUID();
		AsyncMessage msg = new AsyncMessage();
		msg.setDestination("messageFeed");
		msg.setClientId(clientID);
		msg.setMessageId(UUIDUtils.createUUID());
		msg.setTimestamp(System.currentTimeMillis());
		msg.setBody(smooks());
		msgBroker.routeMessageToService(msg, null);
	}
	
	private User smooks()
	{
		Xml2JavaSmooks smooks = new Xml2JavaSmooks();		
		User user = smooks.getUserInfo(this.fileName);
		user.setState(counter++);
		return user;
	}
	

    private Integer counter = 0;
	private String fileName;

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

    
}
