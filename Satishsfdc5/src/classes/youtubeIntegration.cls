public class youtubeIntegration{

    public List<String> result {set;get;}
    public string searchText{get;set;}
    public void show(){
        result=new List<String>();
        Http p=new Http();
        HttpRequest request=new HttpRequest();
        request.setMethod('GET');
        String url='https://www.googleapis.com/youtube/v3/search?part=snippet&q='+searchtext+'&key=AIzaSyArbI-TA8J8MikM_ItYL_QlbnnldUFaI1w';
        request.setEndPoint(url);
        request.setHeader('Content-type', 'application/json');
        HttpResponse response=p.send(request);
       String  jsonresult=response.getBody();
        fromJson js=(fromJSon)JSON.deserialize(jsonresult,fromJSON.class);
        CLS_Items[] items=js.items;
        for(CLS_Items t:items){
           result.add(t.snippet.title);
        }

    }
	public class fromJSON{ 
		public String kind; 
    		public String etag; //"dhbhlDw5j8dK10GxeV_UG6RSReM/MUZ8HNwF_EYNtKzlqxLwOM5sO9g"
		public String nextPageToken; //CAUQAA 
		public cls_pageInfo pageInfo; 
		public cls_items[] items; 
	}

		class cls_pageInfo {	
			public Integer totalResults; //259275 
			public Integer resultsPerPage; //5 
		} 

		class cls_items { 
			public String kind; //youtube#searchResult 
			public String etag; //"dhbhlDw5j8dK10GxeV_UG6RSReM/w14CZ2dqGuFJgx6aWY5jG6JxANQ" 
			public cls_id id; 
			public cls_snippet snippet; 

		} 

		class cls_id { 
			public String kind; //youtube#video 
			public String videoId; //8FbxAGWDPcA 

		}

		public class cls_snippet { 
			public String publishedAt; //2014-06-29T14:02:00.000Z 
			public String channelId; //UCglyNUhDHHxv8cVrf130_Xg 
			public String title; //Facing the Hard Times - Message by Dr. P. SatishKumar 
			public String description; // 
			public cls_thumbnails thumbnails; 
			public String channelTitle; //sureshpec 
			public String liveBroadcastContent; //none 

		} 

		class cls_thumbnails {
			public cls_default default1; 
			public cls_medium medium; 
			public cls_high high; 
		} 

		class cls_default { 
			public String url; //https://i.ytimg.com/vi/8FbxAGWDPcA/default.jpg
		} 

		class cls_medium { 
			public String url; //https://i.ytimg.com/vi/8FbxAGWDPcA/mqdefault.jpg 

		} 

		class cls_high { 
			public String url; //https://i.ytimg.com/vi/8FbxAGWDPcA/hqdefault.jpg 

		}
}