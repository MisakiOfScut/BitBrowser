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
    @EnvironmentObject var BookmarkData: Bookmark
    @State var index: Int = 0
    
    var body: some View {
        HStack {
            TextField("请输入页面url", text: self.$inputUrl, onCommit: {
                inputUrl = inputUrl.lowercased()
                web.webview.load(inputUrl)
            })
                .padding(5)
                .padding(.leading, 5)
                .overlay(
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .stroke(Color("Color_Login"),lineWidth: 2)
                )
            Image(self.isFavorite ? "shoucang" : "weishoucang")
                .onTapGesture {
                    if !isFavorite {
                        self.BookmarkData.add(data: Mark(title: web.webview.webview?.title ?? "default value", webUrl:  (web.webview.webview?.url)?.absoluteString ?? "default value"))
                        self.index = self.BookmarkData.getCount() - 1
                    } else {
                        self.BookmarkData.remove(id: self.index)
                    }
                    self.isFavorite = !self.isFavorite
                    print(self.BookmarkData.count)
                    
                    //清空数据
//                    self.BookmarkData.clear()
                    
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
