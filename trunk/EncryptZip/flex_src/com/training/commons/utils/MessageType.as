package com.training.commons.utils
{
	public class MessageType
	{
		public function MessageType()
		{
		}
		
        //海运原始舱单
        public static const ORIGINAL_SHIP_IMPORT:String = "MT1101";
        
        //空运原始舱单
        public static const ORIGINAL_AIR_IMPORT:String = "MT1201";
        
        //海运预配舱单
        public static const ADVANCE_SHIP_EXPORT:String = "MT2101";
        
        //空运预配舱单
        public static const ADVANCE_AIR_EXPORT:String = "MT2201";
		
        //海运出口运抵
        public static const ARRIVAL_SHIP_EXPORT:String = "MT3101";
		
        //海运分流运抵
        public static const DISTRIBUTE_SHIP_ARRIVAL:String = "MT3102";
		
        //空运出口运抵
        public static const ARRIVAL_AIR_EXPORT:String = "MT3201";
		
        //空运分流运抵
        public static const DISTRIBUTE_AIR_ARRIVAL:String = "MT3202";
		
        //海运出口装载
        public static const LOAD_SHIP_EXPORT:String = "MT4101";
        
        //空运出口装载
        public static const LOAD_AIR_EXPORT:String = "MT4201";
		
        //海运进口理货
        public static const TALLY_SHIP_IMPORT:String = "MT5101";
		
        //海运出口理货
        public static const TALLY_SHIP_EXPORT:String = "MT5102";
		
        //空运进口理货
        public static const TALLY_AIR_IMPORT:String = "MT5201";
        
        //空运出口理货
        public static const TALLY_AIR_EXPORT:String = "MT5202";
        
        //海运进口分流
        public static const DISTRIBUTE_SHIP:String = "MT6101";
		
        //海运进口分拨
        public static const DISPATCH_SHIP:String = "MT6102";
        
        //空运进口分流
        public static const DISTRIBUTE_AIR:String = "MT6201";
		
        //空运进口分拨
        public static const DISPATCH_AIR:String = "MT6202";
	}
}