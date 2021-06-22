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
    @EnvironmentObject var bookMarkPresenter:BookMarkPresenter
    
    var body: some View {
        HStack {
            TextField("请输入页面url", text: self.$inputUrl, onCommit: {
                inputUrl = inputUrl.lowercased()
                web.webview.load(inputUrl)
                //这里能不能返回根据url判断这个页面是否被收藏
                self.isFavorite = false
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
                        self.bookMarkPresenter.add(data: Mark(title: web.webview.webview?.title ?? "default value", webUrl:  (web.webview.webview?.url)?.absoluteString ?? "default value"))
                        self.index = self.bookMarkPresenter.getCount() - 1
                    } else {
                        self.bookMarkPresenter.remove(id: self.index)
                    }
                    print(self.bookMarkPresenter.marklist)
                    print(self.index)
                    self.isFavorite = !self.isFavorite
                    
                    //清空数据
                    self.bookMarkPresenter.clear()

                    //self.BookmarkData.add(data: Mark(title: web.webview.webview?.title ?? "default value", webUrl:  (web.webview.webview?.url)?.absoluteString ?? "default value"))
//                    print(web.webview.webview?.title ?? "default value")
//                    print((web.webview.webview?.url)?.absoluteString ?? "default value")
//                    self.BookmarkData.add(data: Mark(title: "test", webUrl: "https://www.qq.com"))
                    //print(self.BookmarkData.count)
                }
                .scaleEffect(0.8)
        }
        .frame(minWidth: 0, maxWidth: .infinity)
        .padding(.vertical, 10)
        .padding(.horizontal)
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
