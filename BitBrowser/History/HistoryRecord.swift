//
//  HistoryRecord.swift
//  BitBrowser
//
//  Created by Aaron_Chan on 2021/6/9.
//

import Foundation
import ObjectMapper

var _encoder = JSONEncoder()
var _decoder = JSONDecoder()


class HistoryRecord:Mappable, ObservableObject{
    @Published var recordList:[Record] = []
    var count = 0
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: "markList")
    }
    
    init(data: [Record]) {
        for item in data {
            self.recordList.append(Record(recordDate: item.recordDate, url: item.url, webName: item.webName, isRemoved: item.isRemoved, id: item.id))
            self.count += 1
        }
    }
    
    init(){
        if let dataStored = UserDefaults.standard.object(forKey: "recordList") as? Data {
            let data = try! decoder.decode([Record].self, from: dataStored)
            //注意这里id要重新按顺序排
            var id: Int = 0
            for item in data {
                if !item.isRemoved {
                    self.recordList.append(Record(recordDate: item.recordDate, url: item.url, webName: item.webName, isRemoved: item.isRemoved, id: item.id))
                    id += 1
                }
            }
        }
    }
    
    //取消收藏
    func remove(id: Int) {
        self.recordList[id].isRemoved.toggle()
        self.store()
    }
    
    //新增收藏
    func add(data: Record) {
        self.recordList.append(Record(recordDate: data.recordDate, url: data.url, webName: data.webName, isRemoved: data.isRemoved, id: data.id))
        self.count += 1
        self.store()
    }
    
    func dateString_date(id:Int)-> String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat="yyyy-MM-dd"
        return dateformatter.string(from: recordList[id].recordDate)
    }
    
    func dateString_time(id:Int)->String{
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "HH:mm:ss"
        return dateformatter.string(from: recordList[id].recordDate)
    }
    
    func store() {
        let dataStored = try! _encoder.encode(self.recordList)
        UserDefaults.standard.set(dataStored, forKey: "recordList")
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        recordList <- map["recordList"]
    }
}

struct Record:Identifiable, Mappable,Codable{
    var recordDate:Date = Date.distantPast
    var url:URL = URL.init(string: "www.baidu.com")!
    var webName:String = ""
    
    var isRemoved:Bool = false
    
    var id: Int = 0
    
    init?(map: Map) {
        id = 0
    }
    
    init(recordDate:Date,url:URL,webName:String){
        self.recordDate = recordDate
        self.url = url
        self.webName = webName
    }
    
    init(recordDate:Date,url:URL,webName:String,isRemoved:Bool,id:Int){
        self.init(recordDate:recordDate,url:url,webName:webName)
        self.id = id
        self.isRemoved = isRemoved
    }
    
    mutating func mapping(map: Map) {
        webName <- map["recordDate"]
        recordDate <- map["recordDate"]
        url <- map["url"]
    }
}
