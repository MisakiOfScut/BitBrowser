//
//  SearchView.swift
//  BitBrowser
//
//  Created by Aaron_Chan on 2021/6/16.
//

import SwiftUI

struct SearchView: View {
    @State var inputUrl: String = ""
    @State var isFavorite: Bool = false
    @EnvironmentObject var web: Web

//    @EnvironmentObject var BookmarkData: Bookmark
    @State var index: Int = 0
    @EnvironmentObject var bookmarkController:BookmarkController
    
    var body: some View {
        HStack {
            TextField("请输入页面url", text: self.$inputUrl, onCommit: {
                inputUrl = inputUrl.lowercased()
                web.webview.load(inputUrl)
                //这里能不能返回根据url判断这个页面是否被收藏
//                self.isFavorite = self.web.webview.isRemove(url: inputUrl)
                self.isFavorite = !self.bookmarkController.getIsRemove(url: (web.webview.webview?.url)?.absoluteString ?? "default value")
                print("输入网址后是否刷新")
                print((web.webview.webview?.url)?.absoluteString ?? "default value")
                print(self.bookmarkController.marklist)
                print(self.isFavorite)
                
//                print(self.web.webview.getisFavorite())
            })
                .padding(5)
                .padding(.leading, 5)
                .overlay(
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .stroke(Color("Color_Login"),lineWidth: 2)
                )
            Image(self.isFavorite ? "like_fill" : "like")
                .onTapGesture {
                    if !isFavorite {
                        self.bookmarkController.add(data: Mark(title: web.webview.webview?.title ?? "default value", webUrl:  (web.webview.webview?.url)?.absoluteString ?? "default value"))
                    } else {
                        print("删除的网页是")
                        print((web.webview.webview?.url)?.absoluteString ?? "default value")
                        self.bookmarkController.remove(url: (web.webview.webview?.url)?.absoluteString ?? "default value")
                    }
                    print(self.bookmarkController.marklist)
                    self.isFavorite = !self.isFavorite
//
                    //清空数据
//                    self.bookmarkController.clear()
                }
                .scaleEffect(0.8)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.vertical, 10)
        .padding(.horizontal)
        .onAppear() {
//            self.isFavorite = self.web.webview.isRemove(url: inputUrl)
            self.isFavorite = !self.bookmarkController.getIsRemove(url: (web.webview.webview?.url)?.absoluteString ?? "default value")
            print("isfav")
            print(self.isFavorite)
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
