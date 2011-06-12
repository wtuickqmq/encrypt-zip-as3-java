package com.training.commons.utils
{
	public class KeyGenerator   
    {   
        public static const apps:Array = ["BC"]   
        //public static const apps_name:Array = ["BIXXX"]   
        public static const versions:Array = ["1","2","3","4"]   
        //public static const versions_name:Array = ["Beta Home","Beta Proffessional","Home","Proffessional"]   
        public static const MAXDURATION:int = 65535;   
           
        public function KeyGenerator()   
        {   
               
        }   
           
        //////////////////////////////////////////////////   
           
        public static function generateKey(name:String,appname_index:int,version_index:int,dur:int):String   
        {   
            return new KeyGenerator().generate(name,apps[appname_index],versions[version_index],KeyGenerator.MAXDURATION);   
        }   
           
        /**  
         * generate key  
         * @param name username (or email address)  
         * @param appname  
         * @version version  
         * @dur duration time  
         */    
        public function generate(name:String,appname:String,version:String,dur:int):String   
        {   
            trace("producing_params:"+name+" "+appname+" "+version+" "+dur)   
            var factor:Number = 0;   
               
            dur = validateLifeSpan(dur);   
            do  
            {   
                factor = Math.floor(Math.random()*65536)   
            }   
            while(factor<4096)   
               
            var t:Number = Math.floor(new Date().getTime()/86400);   
            var order:Number = Math.floor(Math.random()*16)   
               
            var x1:Number = Math.floor(makeFirstGroup(name,appname,version,factor,t));   
            var r:Number = Math.floor((order^factor)&0xF);   
            var x2:Number = Math.floor(makeSecondGroup(name,factor,dur));   
            var x3:Number = factor;   
            //var x4:Number = Math.floor((((((t>>32)^(order<<4))^factor)&0xFFFF)<<32)+((((t>>16)^factor)&0xFFFF)<<16)+(((t^factor)&0xFFFF)<<0));   
            var x4:Number = Math.floor(((((Math.floor(t/Math.pow(2,32)))^(order*Math.pow(2,4)))^factor)&0xFFFF)*Math.pow(2,32)+((Math.floor(t/Math.pow(2,16))^factor)&0xFFFF)*Math.pow(2,16)+((t^factor)&0xFFFF));   
               
            var hexkey:String = validateGroup(x1.toString(16),4)+validateGroup(r.toString(16),1)+validateGroup(x2.toString(16),4)+validateGroup(x3.toString(16),4)+validateGroup(x4.toString(16),12)   
            var temphexkey:String = "";   
            for(var i:int=0 ; i<hexkey.length ; i+=5)   
            {   
                temphexkey += hexkey.substr(i,5).toUpperCase()+"-";   
            }   
            temphexkey = temphexkey.substr(0,temphexkey.length-1);   
            trace("produced key:"+hexkey+" "+temphexkey)   
               
            return temphexkey;   
        }   
           
           
        private function validateGroup(hex:String,num:int):String   
        {   
            while(hex.length<num)   
            {   
                hex = "0"+hex;   
            }   
            return hex;   
        }   
           
           
        private function validateLifeSpan(dur:int):int  
        {   
            if(dur<1 || dur>KeyGenerator.MAXDURATION)   
            {   
                return KeyGenerator.MAXDURATION   
            }   
            return dur;   
        }   
           
           
        //////////////////////////////////////////////////   
           
        public static function validateKey(key:String,name:String):String   
        {   
            return new KeyGenerator().validate(key,name);   
        }   
           
           
        public function validate(key:String, name:String):String   
        {   
            var result:String = null;   
               
            if(key==null || name==null)   
            {   
                return result;   
            }   
            if(key.indexOf("-")!=-1)   
            {   
                var myPattern:RegExp = /-/g   
                key = key.replace(myPattern,"")   
            }   
               
            var f:Number = decodeFactor(key);   
            var o:Number = decodeOrder(key,f);   
            var d:Number = decodeDuration(key,name,f)   
            var t:Number = decodeTime(key,f);   
            var duration:Number = t;   
            var ct:Number = Math.floor(new Date().getTime()/86400);   
            trace(f+" "+o+" "+d+" "+t+" "+ct)   
               
            if(f!=-1 && o!=-1 && d!=-1 && t!=-1)   
            {   
                for(var i:int=0 ; i<KeyGenerator.apps.length ; i++)   
                {   
                    for(var j:int=0 ; j<KeyGenerator.versions.length ; j++)   
                    {   
                        trace("=======================")   
                        trace(decodeFirstGroup(key))   
                        trace(makeFirstGroup(name,KeyGenerator.apps[i],KeyGenerator.versions[j],f,t))   
                        trace(makeSecondGroup(name,f,d))   
                        trace(decodeSecondGroup(key))   
                           
                           
                        trace("1st: "+(key.length==25));   
                        trace("2nd: "+(makeFirstGroup(name,KeyGenerator.apps[i],KeyGenerator.versions[j],f,t)==decodeFirstGroup(key)));   
                        trace("3rd: "+(makeSecondGroup(name,f,d)==decodeSecondGroup(key)));   
                        trace("4th: "+(t>(ct-duration)));   
                        trace("5th: "+(t<ct));   
                        if(key.length==25 && makeFirstGroup(name,KeyGenerator.apps[i],KeyGenerator.versions[j],f,t)==decodeFirstGroup(key) && makeSecondGroup(name,f,d)==decodeSecondGroup(key) && t>(ct-duration) && t<ct)   
                        {   
                            trace(KeyGenerator.apps[i]);   
                            trace(KeyGenerator.versions[j]);   
                            trace(result);   
                            return KeyGenerator.apps[i]+","+KeyGenerator.versions[j]   
                        }   
                    }   
                }   
            }   
               
            return result   
        }   
           
        /////////////////////////////////////////////////////////////   
           
        private function decodeFactor(hk:String):Number   
        {   
            try  
            {   
                var x:Number = parseInt(hk.substring(9,13),16)   
                return x;   
            }   
            catch(err:NumberFormatException)   
            {   
                trace(err.message)   
            }   
            return -1   
        }   
           
        private function decodeOrder(hk:String, factor:Number):Number   
        {   
            try  
            {   
                var x:Number = parseInt(hk.substring(4,5),16)   
                return (x^factor)&0xF;   
            }   
            catch(err:NumberFormatException)   
            {   
                trace(err.message)   
            }   
            return -1   
        }   
           
        private function decodeDuration(hk:String, name:String, factor:Number):Number   
        {   
            var sg:Number = (decodeSecondGroup(hk)^factor)*Math.pow(2,16)   
            return (Math.floor(sg - (hashcode(name.toLowerCase())&0xFFFF0000))/Math.pow(2,16))&0xFFFF;   
        }   
           
        private function decodeTime(hk:String, factor:Number):Number   
        {   
            var deco:Number = decodeOrder(hk, factor)   
            //trace("deco:"+deco)   
            if(deco == -1)   
            {   
                return deco;   
            }   
            else  
            {   
                try  
                {   
                    var t:Number = parseInt(hk.substring(13),16)   
                    ////trace("t:"+t)   
                    ////trace(277*Math.pow(2,32))   
                    //return (((((t>>32)^factor)^(deco<<4))&0xFFFF)<<32)+((((t>>16)^factor)&0xFFFF)<<16)+(((t>>0)^factor)&0xFFFF);   
                    return (((((Math.floor(t/Math.pow(2,32)))^factor)^(deco*Math.pow(2,4)))&0xFFFF)*Math.pow(2,32))+((((Math.floor(t/Math.pow(2,16)))^factor)&0xFFFF)*Math.pow(2,16))+(((t>>0)^factor)&0xFFFF);   
                }   
                catch(err:NumberFormatException)   
                {   
                    trace(err.message)   
                }   
                return -1   
            }   
        }   
           
        private function decodeSecondGroup(hk:String):Number   
        {   
            try  
            {   
                var x:Number = parseInt(hk.substring(5,9),16)   
                return x;   
            }   
            catch(err:NumberFormatException)   
            {   
                trace(err.message)   
            }   
            return -1   
        }   
           
           
        private function makeFirstGroup(name:String, appname:String, version:String, factor:Number, t:Number):int  
        {   
            var a:Number = hashcode(appname.toLowerCase());   
            var v:Number = hashcode(version.toLowerCase());   
            var n:Number = hashcode(name.toLowerCase());   
            var time:Number = hashcode(t.toString().toLowerCase());   
            ////trace(a+" "+v+" "+n+" "+time)   
            ////trace("makeFirstGroup:"+time*n)   
            return int(Math.abs((((a*v)^factor)+n+time)%65536))   
        }   
           
        private function decodeFirstGroup(hk:String):Number   
        {   
            try  
            {   
                var x:Number = parseInt(hk.substring(0,4),16)   
                return x;   
            }   
            catch(err:NumberFormatException)   
            {   
                trace(err.message)   
            }   
            return -1   
        }   
           
        private function makeSecondGroup(name:String, factor:Number, dur:Number):Number   
        {   
            var n:Number = hashcode(name.toLowerCase());   
            return Math.abs(((Math.floor(((dur*Math.pow(2,16))+n)/Math.pow(2,16)))^factor)&0xFFFF);   
        }   
           
           
        /////////////////////////////////////////////////////////////   
           
        /**  
         * get hashcode as java.lang.string.hashcode()  
         */    
        private function hashcode(s:String):int  
        {   
            var hash:int = 0;   
            for(var i:int=0 ; i<s.length ; i++)   
            {   
                hash = 31*hash + s.charCodeAt(i)   
            }   
            return hash;   
        }   
           
           
        /////////////////////////////////////////////////////////////   
           
        private function parseInt(s:String, radix:int):Number   
        {   
            var result:Number = 0;   
            var i:Number = 0;   
            var max:Number = s.length;   
            var limit:Number = -Number.MAX_VALUE;   
            var multmin:Number = limit/radix;   
            var digit:Number = 0;   
               
            if(max>0)   
            {   
                if(i<max)   
                {   
                    digit = charToInt(s.charAt(i++));   
                    if(digit<0)   
                    {   
                        throw new NumberFormatException("unsupported number")   
                    }   
                    else  
                    {   
                        result = -digit   
                    }   
                }   
                   
                while(i<max)   
                {   
                    digit = charToInt(s.charAt(i++));   
                    if(digit<0)   
                    {   
                        throw new NumberFormatException("unsupported number")   
                    }   
                    if(result<multmin)   
                    {   
                        throw new NumberFormatException("too small")   
                    }   
                    result *= radix;   
                    if(result < limit+digit)   
                    {   
                        throw new NumberFormatException("too small2")   
                    }   
                    result -= digit;   
                }   
            }   
            else  
            {   
                throw new NumberFormatException("unformated")   
            }   
               
            return -result   
        }   
           
        // when radix==16   
        private function charToInt(s:String):Number   
        {   
            if(s.length>1)   
            {   
                return -1   
            }   
            else  
            {   
                if(isNaN(Number(s)))   
                {   
                    s = s.toUpperCase();   
                    switch(s)   
                    {   
                        case "A":   
                            return 10;   
                        case "B":   
                            return 11;   
                        case "C":   
                            return 12;   
                        case "D":   
                            return 13;   
                        case "E":   
                            return 14;   
                        case "F":   
                            return 15;   
                        default:   
                            return -1;   
                    }   
                }   
                else  
                {   
                    return Number(s)   
                }   
            }   
        }   
    }   
}   
  
// NumberFormatException   
class NumberFormatException extends Error   
{   
    public function NumberFormatException(message:String)   
    {   
        super(message)   
    }   
}  
