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
    static var bookmarkController:BookmarkController = BookmarkController()

    init() {
        self.getMarkList()
    }
    
    func getMarkList(){
        
        BookmarkService.getFavourtites(){ (success: Bool, data: Bookmark?, error:Error?) in
            if success{
                print(data?.markList as Any)
                let size:Int = data?.markList.count ?? 0
                if size > 0{
                for index in 0...size-1{
                    data?.markList[index].id = index
                }}
                self.marklist = data?.markList ?? []
                print("bookmarkcontroller getlist之后 marklist 和 count")
                print(self.marklist)
                print(self.marklist.count)
            }else{

            }
        }
    }
    
    //判断该url是否已经被收藏
    func getIsRemove(url: URL) -> Bool{
        print("remove")
        var isR:Bool = true //默认没有被收藏
        print(url.absoluteString)
        for item in self.marklist {
            if item.webUrl == url.absoluteString || item.webUrl == String("https://" + url.absoluteString + "/") {
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
        store()
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
        var temp:[Mark] = []
        for i in 0..<marklist.count{
            if marklist[i].isRemove == false{
                temp.append(marklist[i])
            }
        }
        BookmarkService.addFavourites(bookmarkArrayByJson:temp.toJSON()){ (success: Bool, resp: GeneralResp?, error:Error?) in
            if success{
                print("bookmark upload success")
            }else{
                print("bookmark upload fail")
            }
        }
        
        
        

    }
    //清空本地数据
    func clear() {
        UserDefaults.standard.removeObject(forKey: "markList")
    }
}
