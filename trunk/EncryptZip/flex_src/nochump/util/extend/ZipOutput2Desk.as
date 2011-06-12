/**
 * Copyright (c) 2009 David Yao (xiang.okay@gmail.com)
 * description: Save the file to the desktop
 * author: David Yao
 * mail: xiang.okay@gmail.com
 * mention: gb2312 is for chinese file name and it's also usefull for english file name
 */
package nochump.util.extend {

	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Endian;
	
	import nochump.util.zip.CRC32;
	import nochump.util.zip.Deflater;
	import nochump.util.zip.ZipConstants;
	import nochump.util.zip.ZipEntry;
	import nochump.util.zip.ZipError;
	
	
		
	public class ZipOutput2Desk {
		
		private var _entry:ZipEntry;
		private var _entries:Array = [];
		private var _names:Dictionary = new Dictionary();
		private var _def:Deflater = new Deflater();
		private var _crc:CRC32 = new CRC32();
		private var _buf:ByteArray = new ByteArray();
		private var _comment:String = "";
		
		public function ZipOutput2Desk() {
			_buf.endian = Endian.LITTLE_ENDIAN;
		}
		
		/**
		 * Returns the number of entries in this zip file.
		 */
		public function get size():uint {
			return _entries.length;
		}
		
		/**
		 * Returns the byte array of the finished zip.
		 */
		public function get byteArray():ByteArray {
			_buf.position = 0;
			return _buf;
		}
		
		/**
		 *
		 */
		public function set comment(value:String):void {
			_comment = value;
		}
		
		public function putNextEntry(e:ZipEntry):void {
			if(_entry != null) closeEntry();
			// TODO:
			if(e.dostime == 0) e.time = new Date().time;
			if (e.method == -1) e.method = ZipConstants.DEFLATED; // use default method
			switch(e.method) {
				case ZipConstants.DEFLATED:
					if (e.size == -1 || e.compressedSize == -1 || e.crc == 0) {
						// store size, compressed size, and crc-32 in data descriptor
						// immediately following the compressed entry data
						e.flag = 8;
					} else if (e.size != -1 && e.compressedSize != -1 && e.crc != 0) {
						// store size, compressed size, and crc-32 in LOC header
						if(e.flag != 9)
						  e.flag = 0;
					} else {
						throw new ZipError("DEFLATED entry missing size, compressed size, or crc-32");
					}
					e.version = 20;
					break;
				case ZipConstants.STORED:
					// compressed size, uncompressed size, and crc-32 must all be
					// set for entries using STORED compression method
					if (e.size == -1) {
						e.size = e.compressedSize;
					} else if (e.compressedSize == -1) {
						e.compressedSize = e.size;
					} else if (e.size != e.compressedSize) {
						throw new ZipError("STORED entry where compressed != uncompressed size");
					}
					if (e.size == -1 || e.crc == 0) {
						throw new ZipError("STORED entry missing size, compressed size, or crc-32");
					}
					e.version = 10;
					e.flag = 0;
					break;
				default:
					throw new ZipError("unsupported compression method");
			}
			e.offset = _buf.position;
			if (_names[e.name] != null) {
				throw new ZipError("duplicate entry: " + e.name);
			} else {
				_names[e.name] = e;
			}			
			//writeLOC(e);
			_entries.push(e);
			_entry = e;
		}
		
		public function write(b:ByteArray,password:String=null):void {
			if (_entry == null) {
				throw new ZipError("no current ZIP entry");
			}
			_crc.update(b);
			_entry.crc = _crc.getValue();
			switch (_entry.method) {
				case ZipConstants.DEFLATED:
				    var cb:ByteArray = new ByteArray();
					_def.setInput(b);
					_def.deflate(cb);
					_entry.size = _def.getBytesRead();										
					if(password != null){
						_entry.flag = ZipConstants.DECRYPT;
						_entry.compressedSize = _def.getBytesWritten() +ZipConstants.EXTDATA;						
						 writeLOC(_entry);
						_buf.writeBytes(ZipEncrypt.encryptMessage(cb,_entry,password));
					}else{
						_entry.compressedSize = _def.getBytesWritten();						
						 writeLOC(_entry);
						_buf.writeBytes(cb);
					}					
					break;
				case ZipConstants.STORED:					
					_buf.writeBytes(b);
					break;
				default:
					throw new Error("invalid compression method");
			}
			
		}
		
		// check if this method is still necessary since we're not dealing with streams
		// seems crc and whether a data descriptor i necessary is determined here
		public function closeEntry():void {
			var e:ZipEntry = _entry;
			
			if(e != null) {
				switch (e.method) {
					case ZipConstants.DEFLATED:
						if ((e.flag & 8) == 0) {
							// verify size, compressed size, and crc-32 settings
							if (e.size != _def.getBytesRead()) {
								throw new ZipError("invalid entry size (expected " + e.size + " but got " + _def.getBytesRead() + " bytes)");
							}
							if (e.compressedSize != _def.getBytesWritten()) {
								throw new ZipError("invalid entry compressed size (expected " + e.compressedSize + " but got " + _def.getBytesWritten() + " bytes)");
							}
							if (e.crc != _crc.getValue()) {
								throw new ZipError( "invalid entry CRC-32 (expected 0x" + e.crc + " but got 0x" + _crc.getValue() + ")");
							}
						} else {
							writeEXT(e);
						}
						_def.reset();
						break;
					case ZipConstants.STORED:
						// TODO:
						break;
					default:
						throw new Error("invalid compression method");
				}
				_crc.reset();
				_entry = null;
			}
		}
		
		public function finish():void {
			if(_entry != null) closeEntry();
			if (_entries.length < 1) throw new ZipError("ZIP file must have at least one entry");
			var off:uint = _buf.position;
			// write central directory
			for(var i:uint = 0; i < _entries.length; i++) {
				writeCEN(_entries[i]);
			}
			writeEND(off, _buf.position - off);
		}
		
		private function writeLOC(e:ZipEntry):void {
			_buf.writeUnsignedInt(ZipConstants.LOCSIG);
			_buf.writeShort(e.version);
			_buf.writeShort(e.flag);			
			_buf.writeShort(e.method);
			_buf.writeUnsignedInt(e.dostime); // dostime
			if ((e.flag & 8) == 8) {				
				_buf.writeUnsignedInt(0);
				_buf.writeUnsignedInt(0);
				_buf.writeUnsignedInt(0);
			} else {
				_buf.writeUnsignedInt(e.crc); // crc-32
				_buf.writeUnsignedInt(e.compressedSize); // compressed size
				_buf.writeUnsignedInt(e.size); // uncompressed size
			}
			_buf.writeShort(getLength(e.name));
			_buf.writeShort(e.extra != null ? e.extra.length : 0);
			_buf.writeMultiByte(e.name,"gb2312"); //gb2312 is for chinese file name			
			if (e.extra != null) {
				_buf.writeBytes(e.extra);
			}
			
		}
		
		//the length of the chinese file name
		private function getLength(fileName:String):int{
			return fileName.replace(/[^\x00-\xff]/g,"xx").length;			
		}
		/*
		 * Writes extra data descriptor (EXT) for specified entry.
		 */
		private function writeEXT(e:ZipEntry):void {
			_buf.writeUnsignedInt(ZipConstants.EXTSIG); // EXT header signature
			_buf.writeUnsignedInt(e.crc); // crc-32
			_buf.writeUnsignedInt(e.compressedSize); // compressed size
			_buf.writeUnsignedInt(e.size); // uncompressed size
		}
		
		/*
		 * Write central directory (CEN) header for specified entry.
		 * REMIND: add support for file attributes
		 */
		private function writeCEN(e:ZipEntry):void {
			_buf.writeUnsignedInt(ZipConstants.CENSIG); // CEN header signature
			_buf.writeShort(e.version); // version made by
			_buf.writeShort(e.version); // version needed to extract
			_buf.writeShort(e.flag); // general purpose bit flag
			_buf.writeShort(e.method); // compression method
			_buf.writeUnsignedInt(e.dostime); // last modification time
			_buf.writeUnsignedInt(e.crc); // crc-32			
			_buf.writeUnsignedInt(e.compressedSize); // compressed size			
			_buf.writeUnsignedInt(e.size); // uncompressed size
			_buf.writeShort(getLength(e.name));
			_buf.writeShort(e.extra != null ? e.extra.length : 0);
			_buf.writeShort(e.comment != null ? e.comment.length : 0);
			_buf.writeShort(0); // starting disk number
			_buf.writeShort(0); // internal file attributes (unused)
			_buf.writeUnsignedInt(0); // external file attributes (unused)
			_buf.writeUnsignedInt(e.offset); // relative offset of local header
			_buf.writeMultiByte(e.name,"gb2312");
			if (e.extra != null) {
				_buf.writeBytes(e.extra);
			}
			if (e.comment != null) {
				_buf.writeUTFBytes(e.comment);
			}
		}
		
		/*
		 * Writes end of central directory (END) header.
		 */
		private function writeEND(off:uint, len:uint):void {
			_buf.writeUnsignedInt(ZipConstants.ENDSIG); // END record signature
			_buf.writeShort(0); // number of this disk
			_buf.writeShort(0); // central directory start disk
			_buf.writeShort(_entries.length); // number of directory entries on disk
			_buf.writeShort(_entries.length); // total number of directory entries
			_buf.writeUnsignedInt(len); // length of central directory
			_buf.writeUnsignedInt(off); // offset of central directory
			_buf.writeUTF(_comment); // zip file comment
		}
		
	}
	
}