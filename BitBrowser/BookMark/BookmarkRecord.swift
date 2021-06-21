//
//  BookmarkRecord.swift
//  BitBrowser
//
//  Created by Vivian on 2021/6/17.
//

import Foundation
import ObjectMapper

var encoder = JSONEncoder()
var decoder = JSONDecoder()

// ObservableObject 能够被实时监听到
class Bookmark: Mappable{
    var markList: [Mark] = []
    var count = 0
    
    init(data: [Mark]) {
        for item in data {
            self.markList.append(Mark(title: item.title, webUrl: item.webUrl, id: self.count))
            self.count += 1
        }
    }
    //取消收藏
    func remove(id: Int) {
        self.markList[id].isRemove.toggle()
        self.store()
    }
    //新增收藏
    func add(data: Mark) {
        self.markList.append(Mark(title: data.title, webUrl: data.webUrl, id: self.count))
        self.count += 1
        self.store()
    }
    //数据存储
    func store() {
        let dataStored = try! encoder.encode(self.markList)
        UserDefaults.standard.set(dataStored, forKey: "markList")
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        markList <- map["favourites"]
    }
}

struct Mark: Identifiable, Mappable, Codable{
    var title: String = ""
    var webUrl: String = ""
    var isRemove: Bool = false
    
    //使用identifiable必须有
    var id: Int = 0
    
    init?(map: Map) {
        id = 0
    }
        
    init(title: String, webUrl:String){
        self.title = title
        self.webUrl = webUrl
    }
    
    init(title: String, webUrl:String, id:Int){
        self.init(title: title, webUrl: webUrl)
        self.id = id
    }
    
    mutating func mapping(map: Map) {
        title <- map["title"]
        webUrl <- map["url"]
    }
}
