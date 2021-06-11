//
//  HistoryRecord.swift
//  BitBrowser
//
//  Created by Aaron_Chan on 2021/6/9.
//

import Foundation

class HistoryRecord{
    var recordList:[Record]
    
    init(inputRecordList:[Record]) {
        self.recordList=inputRecordList
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
    
}

struct Record {
    var recordDate:Date
    var url:URL
    var webName:String
}
