//
//  TestNews.swift
//  BitBrowser
//
//  Created by ws on 2021/6/4.
//

import ObjectMapper
/*
"list": [
    {
      "title": "良心跑哪兒去了？任涛剛支援大批物資，周伟就翻臉抹黑",
      "source": "人民資訊",
      "time": "2006-05-27 05:55:09",
      "comments": "412評論",
      "contents": "正文：观但革层北毛干千切切取备及合验族选。想近体物万算四素回江民后公。公万几比状二来平下度地少清越把始。",
      "images": [
        "https://th.bing.com/th/id/R5b1e644f98a8ff671d0dc2667984b965?rik=0qchgsAFHDYM2Q&amp;riu=http%3a%2f%2fwww.leitingw.com%2fuploads%2fallimg%2f200529%2f1321105A1-0.jpg&amp;ehk=KbhTD157OIjNyBCKXsQMzJ%2bjykdgGT26hJ%2f%2bCVbfP1I%3d&amp;risl=&amp;pid=ImgRaw",
        "https://e0.ifengimg.com/12/2019/0114/669C50F456E855C16719528893463EEFC4588B1B_size638_w1024_h671.jpeg",
        "https://himg2.huanqiucdn.cn/attachment2010/2014/0514/20140514064027157.jpg"
      ]
    }
*/

struct TestNews:Mappable{
    var list : [TestNew]?
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        list <- map["list"]
    }
    
    
}

struct TestNew : Mappable{
    var title:String?
    var source:String?
    var time:String?
    var comments:String?
    var contents:String?
    var images:[String]?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        source <- map["source"]
        time <- map["time"]
        comments <- map["comments"]
        contents <- map["contents"]
        images <- map["images"]
    }
}
