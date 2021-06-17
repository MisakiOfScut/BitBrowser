//
//  BookmarkRecord.swift
//  BitBrowser
//
//  Created by Vivian on 2021/6/17.
//

import Foundation

// ObservableObject 能够被实时监听到
class Bookmark: ObservableObject{
    @Published var markList: [Mark]
    var count = 0
    
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
    func remove(id: Int) {
        self.markList[id].isRemove.toggle()
    }
}
struct Mark: Identifiable{
    var title: String = ""
    var webUrl: String = ""
    var isRemove: Bool = false
    
    //使用identifiable必须有
    var id: Int = 0
}
