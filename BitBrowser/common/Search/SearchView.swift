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
//    @State var isFavorite = false
//    let pub = NotificationCenter.default.publisher(for: Notification.Name.init(rawValue: "isFavorite_change"))
    
    var body: some View {
        HStack {
            TextField("请输入页面url", text: self.$inputUrl, onCommit: {
                inputUrl = inputUrl.lowercased()
                ContentView.web.webview.load(inputUrl)
                //这里能不能返回根据url判断这个页面是否被收藏
//                self.isFavorite = self.web.webview.isRemove(url: inputUrl)
                isFavorite = !BookmarkController.bookmarkController.getIsRemove(url: (ContentView.web.webview.webview?.url)?.absoluteString ?? "default value")
                print("searchview输入网址后是否刷新 url marklist isfav")
                print((ContentView.web.webview.webview?.url)?.absoluteString ?? "default value")
                print(BookmarkController.bookmarkController.marklist)
                print(isFavorite)
//                print(self.web.webview.getisFavorite())
            })
                .padding(5)
                .padding(.leading, 5)
                .overlay(
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .stroke(Color("Color_Login"),lineWidth: 2)
                )
            Image(isFavorite ? "like_fill" : "like")
                .onTapGesture {
                    if !isFavorite {
                        BookmarkController.bookmarkController.add(data: Mark(title: ContentView.web.webview.webview?.title ?? "default value", webUrl:  (ContentView.web.webview.webview?.url)?.absoluteString ?? "default value"))
                    } else {
                        print("searchview删除的网页是 url")
                        print((ContentView.web.webview.webview?.url)?.absoluteString ?? "default value")
                        BookmarkController.bookmarkController.remove(url: (ContentView.web.webview.webview?.url)?.absoluteString ?? "default value")
                    }
//                    data.toggle()
                    print("searchview 点击完毕 marklist isfav")
                    print(BookmarkController.bookmarkController.marklist)
                    print(isFavorite)
                    isFavorite = !isFavorite
                    
//
                    //清空数据
//                    BookmarkController.bookmarkController.clear()
                }
                .scaleEffect(0.8)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.vertical, 10)
        .padding(.horizontal)
        .onAppear() {
//            self.isFavorite = self.web.webview.isRemove(url: inputUrl)
            isFavorite = !BookmarkController.bookmarkController.getIsRemove(url: (ContentView.web.webview.webview?.url)?.absoluteString ?? "default value")
            print("searchview出现 isfav")
            print(isFavorite)
        }
//        .onReceive(pub) { output in
//            isFavorite = data.isFavorite
//            data.start()
//        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
