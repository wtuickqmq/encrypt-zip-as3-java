package com.training.demo.service;

import java.io.File;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.List;

import com.training.demo.model.vo.*;
import com.training.demo.model.dao.IUserDao;
import nochump.util.extend.ZipOutput2Flex;
import nochump.util.extend.UnzipFromFlex;

public class DemoService {
	
    public static final String password = "David Yao";
	public static final String download = "C:\\test\\download";
	public static final String upload = "C:\\test\\upload";
	public HashData downloadFile(Object o) {
		MessageDigest mdTemp = null;
		String hashType = "md5";
		try {
			mdTemp = MessageDigest.getInstance(hashType);
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return null;
		}
		File file = new File(download);		
		HashData hashData = new HashData();		
		byte[] zipByte = ZipOutput2Flex.getEncryptZipByte(file.listFiles(), password);
		mdTemp.update(zipByte);		
		byte[] mdByte = mdTemp.digest(); 
		hashData.setZipByte(zipByte);
		hashData.setMdByte(mdByte);
		hashData.setMd(toHexString(mdByte));
		hashData.setHashType(hashType);
		return hashData;
	}


	public String uploadFile(HashData hashData) {
		try {
			if(checkMD(hashData)){				
				System.out.println("------------"+hashData.getHashType()+"------------");
				UnzipFromFlex.unzipFiles(hashData.getZipByte(), password, upload);
			}	

		} catch (IOException e) {
			
			e.printStackTrace();
		}
      return "success";
	}
	
	private Boolean checkMD(HashData hashData){
		MessageDigest mdTemp = null;
		try {
			mdTemp = MessageDigest.getInstance(hashData.getHashType());
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
			return false;
		}
		mdTemp.update(hashData.getZipByte());		
		byte[] md = mdTemp.digest(); 
		System.out.println(MessageDigest.isEqual(hashData.getMdByte(), md));
        System.out.println(hashData.getMd());
        System.out.println(toHexString(md));
		return hashData.getMd().equals(toHexString(md));
	}
	
    public static String toHexString(byte[] b) {   
        StringBuilder sb = new StringBuilder(b.length * 2);   
        for (int i = 0; i < b.length; i++) {   
            sb.append(hexChar[(b[i] & 0xf0) >>> 4]);   
            sb.append(hexChar[b[i] & 0x0f]);   
        }   
        return sb.toString();   
    }	
	
    public static char[] hexChar = {'0', '1', '2', '3',   
        '4', '5', '6', '7',   
        '8', '9', 'a', 'b',   
        'c', 'd', 'e', 'f'}; 
    
	
	public List<?> saveOrUpdate(Object o) {
		return userDao.saveOrUpdate(o);
	}
	
	public List<?> saveOrUpdateAll(Object o)throws Exception {
		return userDao.saveOrUpdateAll(o);
	}
	
	private IUserDao userDao;

	public IUserDao getUserDao() {
		return userDao;
	}

	public void setUserDao(IUserDao userDao) {
		this.userDao = userDao;
	}

	
	
}
