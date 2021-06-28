//
//  BookMarkPresenter.swift
//  BitBrowser
//
//  Created by ws on 2021/6/21.
//

import SwiftUI
import Foundation

class BookmarkController:ObservableObject{
    @Published var marklist:[Mark] = []
    
    func getMarkList(){
        //获取本地数据
        if let dataStored = UserDefaults.standard.object(forKey: "markList") as? Data {
            let data = try! decoder.decode([Mark].self, from: dataStored)
            //注意这里id要重新按顺序排
            var id: Int = 0
            for item in data {
                if !item.isRemove {
                    self.marklist.append(Mark(title: item.title, webUrl: item.webUrl, isRemove: item.isRemove, id: id))
                    id += 1
                }
            }
        }
        //如果用户登录，上传到云端合并并拉下来更新marklist
        
//        BookMarkService.getFavourtites(){ (success: Bool, data: Bookmark?, error:Error?) in
//            if success{
//                print(data?.markList as Any)
//                let size:Int = data?.markList.count ?? 0
//                for index in 0...size-1{
//                    data?.markList[index].id = index
//                }
//                self.marklist = data?.markList ?? []
                print(self.marklist)
                print(self.marklist.count)
//            }else{
//
//            }
//        }
    }
    
    //判断该url是否已经被收藏
    func getIsRemove(url: String) -> Bool{
        var isR:Bool = true //默认没有被收藏
        for item in self.marklist {
            if item.webUrl == url {
                if item.isRemove == false { //marklist中可能有多个同样的url，直到找到isRemove为false的
                    isR = item.isRemove
                    break
                }
            }
        }
        return isR
    }
    //删除书签
    func remove(id: Int) {
        self.marklist[id].isRemove.toggle()
        self.store()
    }
    func remove(url: String) {
        for i in 0..<(self.marklist.count) {
            if self.marklist[i].webUrl == url {
                self.marklist[i].isRemove = true //全都要设为true 不用break
            }
        }
        store()
    }
    //添加书签
    func add(data: Mark) {
        self.marklist.append(Mark(title: data.title, webUrl: data.webUrl, isRemove: false, id: self.marklist.count))
        self.store()
//        self.count += 1
    }
    //获取marklist大小
    func getCount() -> Int{
        return self.marklist.count
    }
    //本地数据存储
    func store() {
        let dataStored = try! encoder.encode(self.marklist)
        UserDefaults.standard.set(dataStored, forKey: "markList")
    }
    //清空本地数据
    func clear() {
        UserDefaults.standard.removeObject(forKey: "markList")
    }
}
