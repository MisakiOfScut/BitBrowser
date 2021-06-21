//
//  BookmarkRecord.swift
//  BitBrowser
//
//  Created by Vivian on 2021/6/17.
//

import Foundation

var encoder = JSONEncoder()
var decoder = JSONDecoder()

// ObservableObject 能够被实时监听到
class Bookmark: ObservableObject{
    @Published var markList: [Mark]
    @Published var count = 0
    
    init() {
        self.markList = []
    }
    init(data: [Mark]) {
        self.markList = []
        for item in data {
            self.markList.append(Mark(title: item.title, webUrl: item.webUrl, id: self.count))
            self.count += 1
        }
    }
    func getCount() -> Int {
        return self.count
    }
    //取消收藏
    func remove(id: Int) {
        self.markList[id].isRemove.toggle()
//        self.count -= 1
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
    //清空数据
    func clear() {
        UserDefaults.standard.removeObject(forKey: "markList")
        self.count = 0
    }
}
struct Mark: Identifiable, Codable{
    var title: String = ""
    var webUrl: String = ""
    var isRemove: Bool = false
    
    //使用identifiable必须有
    var id: Int = 0
}
