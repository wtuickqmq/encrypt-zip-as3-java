/**
 * Copyright (c) 2009 David Yao (xiang.okay@gmail.com)
 * description: This class is supposed to test the information of the format of the encrypt-zip file.
 * author: David Yao
 * mail: xiang.okay@gmail.com 
 */
package nochump.util.test
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	import mx.controls.Alert;
	
	import nochump.util.extend.ZipCrypto;
	import nochump.util.zip.Inflater;
	import nochump.util.zip.ZipEntry;
	
	public class TestUpzip
	{
		public function TestUpzip()
		{
		}
		
		public static function traceInfo(zipByte:ByteArray):void{
				         var byteInfo:ByteArray = new ByteArray();
						 byteInfo.endian = Endian.LITTLE_ENDIAN;
						 zipByte.readBytes(byteInfo);
				
	                     byteInfo.position = 0;
						 //文件标头区	    
						 var e:ZipEntry = new ZipEntry("yx");
						 trace("  位置 文件标头 :" +byteInfo.position);	                
	                     trace("  文件标头签名:"+byteInfo.readUnsignedInt().toString(16));
	                     trace("  所需版本 :"+byteInfo.readUnsignedShort());
	                     var flag:int =  byteInfo.readUnsignedShort();                
	                     trace("  一般用途位标记:"+flag);
	                     e.method = byteInfo.readUnsignedShort();	                     
	                     trace("  压缩方法:"+e.method);
	                     var time:uint =    byteInfo.readUnsignedInt();
	                     trace("  文件的最后修改时间 :"+ time );
	                     //trace("  文件的最后修改日期 :"+ time );
	                     e.crc =  byteInfo.readUnsignedInt();	                                          
	                     trace("  crc-32 :"+ e.crc);
	                     e.compressedSize = byteInfo.readUnsignedInt();
	                     trace("  压缩后的大小 :"+ e.compressedSize);
	                     e.size = byteInfo.readUnsignedInt();
	                     trace("  解压缩后的大小 :"+e.size);
	                     var nal:int = byteInfo.readUnsignedShort();
	                     trace("  文件名长度 :"+nal);
	                     var extL:int = byteInfo.readUnsignedShort();
	                     trace("  额外字段长度 :"+ extL);
	                     e.name = byteInfo.readUTFBytes(nal);
	                     trace("  文件名 :"+ e.name);
	                     if(extL >0)
	                     byteInfo.readBytes(e.extra,0,extL);
	                     trace("  额外字段 :"+ e.extra);
	                     
	                     var plainText:ByteArray = new ByteArray();	       
	                      if(flag == 9){
	                      	//数据区
	                     	var ex12Data:ByteArray = new ByteArray();
	                     	var byteData:ByteArray = new ByteArray();
	                     	  
		                     ZipCrypto.InitCipher("123456");	                     
		                     byteInfo.readBytes(ex12Data,0,12);	                     
		                     var DecryptedHeader:ByteArray  =ZipCrypto.DecryptMessage(ex12Data,12);  
		                     //判断密码的正确性
		                     trace(DecryptedHeader[11]);		                     
		                     trace((time >> 8) & 0xff);	
	
		                     if (DecryptedHeader[11] != ((e.crc >> 24) & 0xff)){
				
				                if ((9 & 0x0008) != 0x0008){
				                	throw new Error("The password did not match.");
				                }
				                else if (DecryptedHeader[11] != ((time >> 8) & 0xff))   {
				                	throw new Error("The password did not match.");
				                }       
				                
				               }
				               
	                        byteInfo.readBytes(byteData,0,e.compressedSize-12);
	                        plainText = ZipCrypto.DecryptMessage(byteData,e.compressedSize-12);
	                      }
	                      else{
	                      	
	                      	byteInfo.readBytes(plainText,0,655);
	                      }
	                     trace("  读完数据区位置  :" +byteInfo.position); 	                        
	                     var b2:ByteArray = new ByteArray();
						 var inflater:Inflater = new Inflater();
						 inflater.setInput(plainText);
						 inflater.inflate(b2);
	                     Alert.show(String(b2));
	                     
	                     //数据描述符记录
	                     if(flag == 8 || flag ==9 ){
	                     	trace(" ----------------");
	                        trace("  位置 数据描述符记录 :" +byteInfo.position);	
	                        trace("  数据标签 :" +byteInfo.readUnsignedInt().toString(16));
	                        trace("  crc-32 :" +byteInfo.readUnsignedInt());
	                        trace("  压缩后的大小 :" +byteInfo.readUnsignedInt());
	                        trace("  解压缩后的大小 :" +byteInfo.readUnsignedInt());
	                     }
	                     
	                     
	                     //进入中央目录结构->文件标头
	                     trace(" ----------------");
	                     trace("  位置 进入中央目录结构->文件标头:" +byteInfo.position);	                     
	                     trace(" 中央文件标头签名:"+ byteInfo.readUnsignedInt().toString(16));
						 trace(" version made by :"+ byteInfo.readUnsignedShort()); 
						 trace(" 所需版本       :"+ byteInfo.readUnsignedShort()); 
						 trace(" 一般用途位标记 :"+ byteInfo.readUnsignedShort());
						 trace(" 压缩方法       :"+ byteInfo.readUnsignedShort());
						 trace(" 文件的最后修改时间  :"+ byteInfo.readUnsignedInt());
						 trace(" crc-3        :"+ byteInfo.readUnsignedInt());      
						 trace(" 压缩后的大小 :"+ byteInfo.readUnsignedInt());      
						 trace(" 解压缩后的大小 :"+ byteInfo.readUnsignedInt());
						 var cname:int =   byteInfo.readUnsignedShort();  
						 trace(" 文件名长度   :"+ cname);   
						 var celength:int =   byteInfo.readUnsignedShort();   
						 trace(" 额外字段长度 :"+ celength);  
						 var cfplain:int =   byteInfo.readUnsignedShort();    
						 trace(" 文件注释长度 :"+ cfplain);      
						 trace(" 磁盘开始号   :"+ byteInfo.readUnsignedShort());      
						 trace(" 内部文件属性 :"+ byteInfo.readUnsignedShort());       
						 trace(" 外部文件属性 :"+ byteInfo.readUnsignedInt());       
						 trace(" 相关的标头偏移量 :"+ byteInfo.readUnsignedInt());						 
	                     trace("  文件名 :"+ byteInfo.readUTFBytes(cname));	                     
	                     trace("  额外字段 :"+ byteInfo.readUTFBytes(celength));	                     	 
	                     trace("  文件注释 :"+ byteInfo.readUTFBytes(cfplain));
	                     ////进入中央目录结构->结尾
	                     trace(" ----------------");
	                     trace("  位置 进入中央目录结构->结尾:" +byteInfo.position);
	                     trace(" 中央目录记录签名               :"  + byteInfo.readUnsignedInt().toString(16));
						 trace(" 磁盘编号                       :" + byteInfo.readUnsignedShort()); 
						 trace(" 中央目录开始磁盘编号           :"  + byteInfo.readUnsignedShort()); 
						 trace(" 本磁盘上在中央目录里的入口总数 :"   + byteInfo.readUnsignedShort()); 
						 trace(" 中央目录里的入口总数           :"  + byteInfo.readUnsignedShort()); 
						 trace(" 中央目录的大小                 :" + byteInfo.readUnsignedInt()); 
						 trace(" 中央目录对第一张磁盘的偏移量   :" + byteInfo.readUnsignedInt());
						 var cLeng:int = byteInfo.readUnsignedShort(); 
						 trace(" .ZIP 文件注释长度              :" + cLeng);						 
						 trace(" .ZIP 文件注释                  :" + byteInfo.readUTFBytes(cLeng));
						 trace("  结束位置 :" +byteInfo.position); 	                     
	                     
		}

	}
}