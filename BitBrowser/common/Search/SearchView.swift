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
    var body: some View {
        HStack {
            TextField("请输入页面url", text: self.$inputUrl)
                .padding(10)
                .padding(.leading)
                .overlay(
                RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/)
                    .stroke(Color("Color_Login"),lineWidth: 2)
            )
            Image(self.isFavorite ? "shoucang" : "weishoucang")
                .onTapGesture {
                    self.isFavorite = !self.isFavorite
//                    web.webview.load("https://qq.com")
                }
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
