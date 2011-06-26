/**
 * Copyright (c) 2009 David Yao (xiang.okay@gmail.com)
 * description: Test the function of Encryption and Decrytion the zipfile 
 *  with password
 * author: David Yao
 * mail: xiang.okay@gmail.com
 */

package com.training.demo.Test;

import java.io.File;
import java.io.IOException;

import com.training.commons.file.FileUtils;

import nochump.util.extend.UnzipFromFlex;
import nochump.util.extend.ZipOutput2Flex;
import org.junit.Test;


public class ZipFileWithPassword {

	
	public static final String zipDir = "C:\\test\\download";
	public static final String EncryptZipFile = "C:\\test\\download\\Encrypt.zip";
	public static final String password = "David Yao";
	
	@Test
	public void TestEncryptZipFile() {
		
		File file = new File(zipDir);	
		byte[] zipByte = ZipOutput2Flex.getEncryptZipByte(file.listFiles(), password);
		FileUtils.writeByteFile(zipByte, new File(EncryptZipFile));
		
	}
	
	@Test
	public void TestDecryptZipFile() {
		
		File file = new File(EncryptZipFile);	
		byte[] zipByte = FileUtils.readFileByte(file);
		try {
			UnzipFromFlex.unzipFiles(zipByte,password, zipDir);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
	 
	
	
	
	

}
