/**
 * Copyright (c) 2009 David Yao (xiang.okay@gmail.com)
 * description: Crypt the file
 * author: David Yao
 * mail: xiang.okay@gmail.com
 */
		 
package nochump.util.extend
{	
	import flash.utils.ByteArray;	
	import nochump.util.zip.CRC32;
	
	public class ZipCrypto 
	{
		private static var _Keys:Array =  new Array(0x12345678, 0x23456789, 0x34567890);		
		
		private static function MagicByte():int{
			var t:int;
			t = ((_Keys[2] & 0xffff) | 2) & 0xffff;
			return ((t * (t ^ 1)) >> 8) & 0xff;
			
		}
		
		private static function UpdateKeys(byteValue:int):void {		    
			_Keys[0] = uint(CRC32.update(int(_Keys[0]), byteValue));			 
			_Keys[1] = _Keys[1] + (_Keys[0] & 0xff);			
			_Keys[1] = CRC32.calcUnit32(_Keys[1])+ 1;			 					
			_Keys[2] = uint(CRC32.update(int(_Keys[2]), (_Keys[1] >> 24) & 0xff));
		}
		
		public static function InitCipher( passphrase:String):void{
	       
			_Keys[0] = 0x12345678;
			_Keys[1] = 0x23456789;
			_Keys[2] = 0x34567890;			
	        for (var i:int = 0; i < passphrase.length; i++) {
	            UpdateKeys(passphrase.charCodeAt(i));
	        }
	    }
	    
		 public static function DecryptMessage(cipherText:ByteArray, length:int):ByteArray{
	    
			var plainText:ByteArray = new ByteArray();
			
	        for (var i:int = 0; i < length; i++)
	        {	
	            var C:int = cipherText[i] ^ MagicByte();
	        	UpdateKeys(C);
	            plainText.writeByte(C);
	        }	        
	        return plainText;
	    }
	    
	    public static function EncryptMessage(plainText:ByteArray, length:int):ByteArray{
	    
			var cipherText:ByteArray = new ByteArray();
			
	        for (var i:int = 0; i < length; i++)
	        {	        	
	            var C:int = plainText[i];
	            cipherText.writeByte(C^MagicByte());
	            UpdateKeys(C);
	        }	        
	        return cipherText;
	    }
	    
	    
		
	    
	    
	    	

	}
}