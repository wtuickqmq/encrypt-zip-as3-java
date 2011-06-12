package com.training.commons.utils
{
	public class Page
	{
		private var _totalPage:int = 0;   //总页数

		private var _totalrows:int = 0;   //总记录
	
		private var _correntPage:int = 0;  //当前页码
	
		private var _start:int = 0;      //开始位置
	
		private var _end:int = 0;        //结束位置
	 
		private var _pagenum:int = 0;     //页大小
	
		private var _hasPreviousPage:Boolean = false;   //是否有上一页
	
		private var _hasNextPage:Boolean = false;      //是否有下一页
	
		private var _newc:Array = null;
		
		public function Page(newc:Array,pagenum:int):void
		{
			//得到单页显示数字
			this._pagenum = pagenum;
			//得到所有集合
			this._newc = newc;
			_totalrows = newc.length;
			_correntPage =(_totalrows == 0)?0:1;					//判断是否有记录
			_start = 0;
			_hasPreviousPage = false;
			_totalPage = (_totalrows % pagenum == 0)?_totalrows / pagenum:(_totalrows / pagenum + 1);
			_hasNextPage = (_totalPage > 1)? true:false;			//判断是不是就一页
			_end = (_totalrows < pagenum)?_totalrows:pagenum;		//看记录数量是否不到一页
		}
	
		public function getNextPageData():Array 
		{	
			//按下一页按钮
			_correntPage++;		
			_hasPreviousPage =  true;
			_hasNextPage = (_correntPage >= _totalPage)?false:true;		//判断是否需要下一页按钮
			_start = _end ;
			_end = (_totalrows - _correntPage * _pagenum)>0?(_start + _pagenum):_totalrows;//看记录数量是否不到一页
			if (_correntPage > _totalPage)								//当前页超过总页按最后一页算
			{
				_correntPage = _totalPage;
				_start = (_totalPage - 1) * _pagenum ;
				_end = _totalrows;
			}
			return this.getData();
		}

		public function getPreviousPageData():Array  
		{
			_correntPage--;
			_hasNextPage =  true;
			_hasPreviousPage = (_correntPage <= 1)?false:true;			//判断是否需要上一页按钮
			_end = _start;
			_start = _end - _pagenum ;
			if (_correntPage < 1)										//当前页小于第一页按第一页算
			{
				_correntPage = 1;
				_start = 0;
				_end = (_totalrows < _pagenum)?_totalrows:_pagenum;			
			}
			return this.getData();
		}

		public function getPage(_correntPage:int):Array						//传入要显示的页码数
		{
			this._correntPage=_correntPage;	
			if (_correntPage <= 1)									    //当前页小于第一页按第一页算
			{
				_hasPreviousPage = false;
				_hasNextPage = (_totalPage > 1)? true:false;
				this._correntPage = 1;
				_start = 0;
				_end = (_totalrows < _pagenum)?_totalrows:_pagenum;
			}
			else if (_correntPage >= _totalPage)							//当前页超过总页按最后一页算
			{
				_hasPreviousPage = (_totalPage > 1)? true:false;
				_hasNextPage = false;
				this._correntPage = _totalPage;
				_start = (_totalPage - 1) * _pagenum ;
				_end = _totalrows;
			}
			else														//正常页
			{
				_hasPreviousPage = true;
				_hasNextPage = true;
				_start = (this._correntPage - 1) * _pagenum;
				_end = (_totalrows - _correntPage * _pagenum)>0?(_start + _pagenum):_totalrows;
			}
			return this.getData();
		}
	
		public function getData():Array 
		{									//得到需要的纪录条数
			var coll:Array = new Array();
			_start = (_start <=0)?0:_start;
			_end = (_end <=0)?0:_end;
			coll = _newc.slice(_start, _end);
			return coll;
		}
		
		public function get totalPage():int   //总页数
		{
			return _totalPage; 
		}

		public function get totalrows():int   //总记录
		{
			return _totalrows;
		}
	
		public function get correntPage():int  //当前页码
		{
			return _correntPage;
		}
	 
		public function get pagenum():int     //页大小
		{
			return _pagenum;
		}
	
		public function get hasPreviousPage():Boolean   //是否有上一页
		{
			return _hasPreviousPage;
		}
	
		public function get hasNextPage():Boolean      //是否有下一页
		{
			return _hasNextPage;
		}
	
		public function get allData():Array
		{
			return _newc; 
		}
		
	}
}