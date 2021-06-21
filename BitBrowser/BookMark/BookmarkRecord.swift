//
//  BookmarkRecord.swift
//  BitBrowser
//
//  Created by Vivian on 2021/6/17.
//

import Foundation
import ObjectMapper

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
    
    func remove(id: Int) {
        self.markList[id].isRemove.toggle()
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        markList <- map["favourites"]
    }
}

struct Mark: Identifiable, Mappable{
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
