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
    @State var index: Int = 0
    @State var isfav2 = false
    let pub = NotificationCenter.default.publisher(for: Notification.Name.init(rawValue: "get_isfav"))
    @EnvironmentObject var web:Web
    var body: some View {
        HStack {
            TextField("请输入页面url", text: self.$inputUrl, onCommit: {
                inputUrl = inputUrl.lowercased()
                self.web.webview.load(inputUrl)
                //这里能不能返回根据url判断这个页面是否被收藏
                isfav.setisfav(val: !BookmarkController.bookmarkController.getIsRemove(url: (self.web.webview.webview?.url)!))
                print("------------")
                print((self.web.webview.webview?.url)?.relativePath)
                print("searchview输入网址后是否刷新 url marklist isfav")
                print((self.web.webview.webview?.url)?.absoluteString ?? "default value")
                print(BookmarkController.bookmarkController.marklist)
                print(isFavorite)
            })
                .padding(5)
                .padding(.leading, 5)
                .overlay(
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .stroke(Color("Color_Login"),lineWidth: 2)
                )
            
            Image(self.isfav2 ? "like_fill" : "like")
                .onTapGesture {
                    if !isfav.getisfav() {
                        BookmarkController.bookmarkController.add(data: Mark(title: self.web.webview.webview?.title ?? "default value", webUrl:  (self.web.webview.webview?.url)?.absoluteString ?? "default value"))
                    } else {
                        print("searchview删除的网页是 url")
                        print((self.web.webview.webview?.url)?.absoluteString ?? "default value")
                        BookmarkController.bookmarkController.remove(url: (self.web.webview.webview?.url)?.absoluteString ?? "default value")
                    }
                    isfav.setisfav(val: !self.isfav2)
                    print("searchview 点击完毕 marklist isfav")
                    print(BookmarkController.bookmarkController.marklist)
                    print(isfav.getisfav())
                    
                }
                .scaleEffect(0.8)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.vertical, 10)
        .padding(.horizontal)
        .onAppear() {
            isfav.setisfav(val: !BookmarkController.bookmarkController.getIsRemove(url: (self.web.webview.webview?.url)!))
            print("searchview出现 isfav")
            print(isFavorite)
            
        }
        .onReceive(pub) { output in
            isfav2 = isfav.isfav
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
