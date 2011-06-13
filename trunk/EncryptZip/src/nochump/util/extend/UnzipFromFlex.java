/**
 * Copyright (c) 2009 David Yao (xiang.okay@gmail.com)
 * description: Crypt the file
 * author: David Yao
 * mail: xiang.okay@gmail.com
 */
package nochump.util.extend;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;

import com.training.commons.file.FileUtils;
import nochump.util.zip.EncryptZipEntry;
import nochump.util.zip.EncryptZipInput;

public class UnzipFromFlex {


	public static void unzipFiles(byte[] zipBytes, String password, String dir) throws IOException {
		InputStream bais = new ByteArrayInputStream(zipBytes);
		EncryptZipInput zin = new EncryptZipInput(bais,password);
		EncryptZipEntry ze;		
		while ((ze = zin.getNextEntry()) != null) {
			ByteArrayOutputStream toScan = new ByteArrayOutputStream();
			byte[] buf = new byte[1024];
			int len;
			while ((len = zin.read(buf)) > 0) {
				toScan.write(buf, 0, len);
			}
			byte[] fileOut = toScan.toByteArray();
			toScan.close();			
			FileUtils.writeByteFile(fileOut, new File(dir+File.separator+ze.getName()));
			
		}
		zin.close();
		bais.close();
	}
	
}
