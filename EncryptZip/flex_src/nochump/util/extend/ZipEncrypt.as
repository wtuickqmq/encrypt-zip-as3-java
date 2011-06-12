/**
 * Copyright (c) 2009 David Yao (xiang.okay@gmail.com)
 * description: Encrypt the file
 * author: David Yao
 * mail: xiang.okay@gmail.com
 */
package nochump.util.extend
{
	import flash.utils.ByteArray;
	import nochump.util.zip.ZipEntry;
	import nochump.util.extend.ZipCrypto;
	
	public class ZipEncrypt
	{
		public function ZipEncrypt()
		{
		}
		
		public static function encryptMessage(buf:ByteArray, entry:ZipEntry, password:String):ByteArray
		{
			var dataByte :ByteArray = new ByteArray();
			var header:ByteArray = setAddHeader((entry.dostime>>8)& 0xff);				        
	        ZipCrypto.InitCipher(password);
	        dataByte.writeBytes(ZipCrypto.EncryptMessage(header,12));
	        dataByte.writeBytes(ZipCrypto.EncryptMessage(buf,buf.length));
		    return dataByte;	
		}
		
		private static function setAddHeader(check:int):ByteArray
		{
			var header:ByteArray = new ByteArray();
			for(var i:int= 0;i<11;i++)
			  header.writeByte(Math.round(0xff));
			  header.writeByte(check);			  
			return header;
		}

	}
}