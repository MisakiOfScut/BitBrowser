//
//  BookMarkPresenter.swift
//  BitBrowser
//
//  Created by ws on 2021/6/21.
//

import SwiftUI

class BookMarkPresenter:ObservableObject{
    @Published var marklist:[Mark] = []
    
    func getMarkList(){
        BookMarkService.getFavourtites(){ (success: Bool, data: Bookmark?, error:Error?) in
            if success{
                print(data?.markList as Any)
                let size:Int = data?.markList.count ?? 0
                for index in 0...size-1{
                    data?.markList[index].id = index
                }
                self.marklist = data?.markList ?? []
                print(self.marklist)
                print(self.marklist.count)
            }else{
                
            }
        }
    }
    //删除书签
    func remove(id: Int) {
        self.marklist[id].isRemove.toggle()
    }
    //添加书签
    func add(data: Mark) {
        self.marklist.append(Mark(title: data.title, webUrl: data.webUrl, isRemove: false, id: self.marklist.count))
//        self.count += 1
    }
    //获取marklist大小
    func getCount() -> Int{
        return self.marklist.count
    }
}
