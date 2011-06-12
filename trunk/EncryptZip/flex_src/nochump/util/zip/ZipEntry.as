/*
com.adobe.ziputils.zip.ZipEntry
Copyright (c) 2008 David Chang (dchang@nochump.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
*/
package nochump.util.zip {
	
	import com.universalmind.cairngorm.vo.ValueObject;
	
	import flash.utils.ByteArray;
	/**
	 * This class represents a member of a zip archive.  ZipFile
	 * will give you instances of this class as information
	 * about the members in an archive.  On the other hand ZipOutput
	 * needs an instance of this class to create a new member.
	 *
	 * @author David Chang
	 */
	 [Bindable]	
	public class ZipEntry extends com.universalmind.cairngorm.vo.ValueObject{
		
		// some members are internal as ZipFile will need to set these directly
		// where their accessor does type conversion
		private var _name:String;		
		private var _size:int = -1;
		private var _compressedSize:int = -1;
		private var _crc:uint;
		/** @private */
		private var _dostime:uint;
		private var _method:int = -1; // compression method
		private var _extra:ByteArray; // optional extra field data for entry
		private var _comment:String; // optional comment string for entry
		// The following flags are used only by ZipOutput
		/** @private */
		private var _flag:int; // bit flags
		/** @private */
		private var _version:int; // version needed to extract
		/** @private */
		private var _offset:int; // offset of loc header
		
		/**
		 * Creates a zip entry with the given name.
		 * @param name the name. May include directory components separated
		 * by '/'.
		 */
	
		public function ZipEntry(name:String) {
			_name = name;
		}
		
		
		
		
		/**
		 * Returns the entry name.  The path components in the entry are
		 * always separated by slashes ('/').  
		 */
		public function get name():String {
			return _name;
		}
		
		public function set name(fileName:String):void {
			 _name = fileName;
		} 
		
		
		/**
		 * Gets the time of last modification of the entry.
		 * @return the time of last modification of the entry, or -1 if unknown.
		 */
		public function get time():Number {
			var d:Date = new Date(
				((dostime >> 25) & 0x7f) + 1980,
				((dostime >> 21) & 0x0f) - 1,
				(dostime >> 16) & 0x1f,
				(dostime >> 11) & 0x1f,
				(dostime >> 5) & 0x3f,
				(dostime & 0x1f) << 1
			);
			return d.time;
		}
		/**
		 * Sets the time of last modification of the entry.
		 * @time the time of last modification of the entry.
		 */
		public function set time(time:Number):void {
			var d:Date = new Date(time);
			dostime =
				(d.fullYear - 1980 & 0x7f) << 25
				| (d.month + 1) << 21
				| d.day << 16
				| d.hours << 11
				| d.minutes << 5
				| d.seconds >> 1;
		}
		
		/**
		 * Gets the size of the uncompressed data.
		 */
		public function get size():int {
			return _size;
		}
		/**
		 * Sets the size of the uncompressed data.
		 */
		public function set size(size:int):void {
			_size = size;
		}
		
		/**
		 * Gets the size of the compressed data.
		 */
		public function get compressedSize():int {
			return _compressedSize;
		}
		/**
		 * Sets the size of the compressed data.
		 */
		public function set compressedSize(csize:int):void {
			_compressedSize = csize;
		}
		
		/**
		 * Gets the crc of the uncompressed data.
		 */
		public function get crc():uint {
			return _crc;
		}
		/**
		 * Sets the crc of the uncompressed data.
		 */
		public function set crc(crc:uint):void {
			_crc = crc;
		}
		public function get dostime():uint {
			return _dostime;
		}
		
		public function set dostime(dostime:uint):void {
			_dostime = dostime;
		}
		/**
		 * Gets the compression method. 
		 */
		public function get method():int {
			return _method;
		}
		/**
		 * Sets the compression method.  Only DEFLATED and STORED are
		 * supported.
		 */
		public function set method(method:int):void {
			_method = method;
		}
		
		/**
		 * Gets the extra data.
		 */
		public function get extra():ByteArray {
			return _extra;
		}
		/**
		 * Sets the extra data.
		 */
		public function set extra(extra:ByteArray):void {
			_extra = extra;
		}
		
		/**
		 * Gets the extra data.
		 */
		public function get comment():String {
			return _comment;
		}
		/**
		 * Sets the entry comment.
		 */
		public function set comment(comment:String):void {
			_comment = comment;
		}
		/**
		 * Gets the extra data.
		 */
		public function get flag():int {
			return _flag;
		}
		/**
		 * Sets the entry comment.
		 */
		public function set flag(flag:int):void {
			_flag = flag;
		}
		/**
		 * Gets the extra data.
		 */
		public function get version():int {
			return _version;
		}
		/**
		 * Sets the entry comment.
		 */
		public function set version(version:int):void {
			_version = version;
		}
		/**
		 * Gets the extra data.
		 */
		public function get offset():int {
			return _offset;
		}
		/**
		 * Sets the entry comment.
		 */
		public function set offset(offset:int):void {
			_offset = offset;
		}
		
		/**
		 * Gets true, if the entry is a directory.  This is solely
		 * determined by the name, a trailing slash '/' marks a directory.  
		 */
		public function isDirectory():Boolean {
			return _name.charAt(_name.length - 1) == '/';
		}
		
		/**
		 * Gets the string representation of this ZipEntry.  This is just
		 * the name as returned by name.
		 */
		public function toString():String {
			return _name;
		}		 

	    
	    /*
	    *fix error:ArgumentError: Error #1063
	    *
	    */
		public override function clone():Object {

            var clone:Object = super.clone();            
            var entry:ZipEntry = new ZipEntry(clone.name);
            entry.fill(clone);
            return entry;
			
		}
		
		
	}
	
}