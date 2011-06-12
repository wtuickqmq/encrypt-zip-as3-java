/**
 * Copyright (c) 2009 David Yao (xiang.okay@gmail.com)
 * description: Decrypt the file
 * author: David Yao
 * mail: xiang.okay@gmail.com
 */
package nochump.util.extend
{
	import flash.utils.ByteArray;
	import nochump.util.zip.ZipEntry;
	import nochump.util.zip.ZipError;
	
	public class ZipDecrypt
	{
		public function ZipDecrypt()
		{
		}
		
		public static function decryptMessage(buf:ByteArray, entry:ZipEntry, password:String):ByteArray
		{
			var ex12Data:ByteArray = new ByteArray();
	        var byteData:ByteArray = new ByteArray();
	        ZipCrypto.InitCipher(password);	                     
	        buf.readBytes(ex12Data,0,12);	 
	        ex12Data = ZipCrypto.DecryptMessage(ex12Data,12);
			 if (ex12Data[11] != ((entry.crc >> 24) & 0xff)){			
			      if ((entry.flag  & 0x0008) != 0x0008){
			     		throw new ZipError("The password did not match.");
			       } else if (ex12Data[11] != ((entry.dostime >> 8) & 0xff))   {
			           throw new ZipError("The password did not match.");
			       }
			}
			buf.readBytes(byteData,0,entry.compressedSize-12);
		    return ZipCrypto.DecryptMessage(byteData,entry.compressedSize-12);	
		}

	}
}