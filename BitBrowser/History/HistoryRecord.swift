//
//  HistoryRecord.swift
//  BitBrowser
//
//  Created by Aaron_Chan on 2021/6/9.
//

import Foundation
import ObjectMapper


class HistoryRecord:Mappable, ObservableObject{
    @Published var recordList:[Record] = []
    static var historyRecord:HistoryRecord = HistoryRecord()
    var count = 0
    var deleted = 0
    
    func clear() {
        UserDefaults.standard.removeObject(forKey: "recordList")
        self.deleted = self.count
        for i in 0..<self.count{
            recordList[i].isRemoved = true
        }
    }
    
    init(data: [Record]) {
        for item in data {
            self.recordList.append(Record(recordDate: item.recordDate, url: item.url, webName: item.webName, isRemoved: item.isRemoved, id:self.count))
            self.count += 1
        }
    }
    
    init(){
        if let dataStored = UserDefaults.standard.object(forKey: "recordList") as? Data {
            let data = try! decoder.decode([Record].self, from: dataStored)
            //注意这里id要重新按顺序排
            for item in data {
                if !item.isRemoved {
                    self.recordList.append(Record(recordDate: item.recordDate, url: item.url, webName: item.webName, isRemoved: item.isRemoved, id: self.count))
                    count += 1
                }
            }
            self.sort()
        }
    }
    
    //取消收藏
    func remove(id: Int) {
        var index:Int = id
        if isFirst(index: id){
            recordList[id] = Record(recordDate: recordList[id+1].recordDate, url: recordList[id+1].url, webName: recordList[id+1].webName, isRemoved: false, id: id)
            index += 1
            print("dd")
        }
        self.recordList[index].isRemoved.toggle()
        deleted += 1
        var temp = recordList[index]
        temp.id = self.count - 1
        for i in index..<self.count-1{
            self.recordList[i] = self.recordList[i+1]
            self.recordList[i].id = i
            print(i)
        }
        self.recordList[self.count - 1] = temp
        
        self.store()
    }
    
    //新增收藏
    func add(data: Record) {
        self.recordList.append(Record(recordDate: data.recordDate, url: data.url, webName: data.webName, isRemoved: false, id:self.count-self.deleted))//要将新增的放在准确的排序当中
        var temp:Record
        temp = recordList[self.count-self.deleted]
        recordList[self.count-self.deleted] = recordList[self.count]
        recordList[self.count]=temp
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
        let dataStored = try! encoder.encode(self.recordList)
        UserDefaults.standard.set(dataStored, forKey: "recordList")
    }
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        recordList <- map["recordList"]
    }
    
    func isFirst(index:Int)->Bool{
        if index == self.count - 1{
            return false
        }
        else if dateString_date(id: index) == dateString_date(id: index+1){
            return true
        }
        return false
    }
    
    func sort(){
        self.recordList.sort(by: {(data1,data2) in
            return data1.recordDate.timeIntervalSince1970<data2.recordDate.timeIntervalSince1970
        })
        for i in 0..<self.recordList.count{
            self.recordList[i].id = i
        }
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
